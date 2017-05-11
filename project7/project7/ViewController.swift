//
//  ViewController.swift
//  project7
//
//  Created by Elliot Ross on 02/05/2017.
//  Copyright © 2017 Elliot Ross. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [[String: String]]()
    //This creates an array of dictionarys with a String for its key and a String for its Value.
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        func parse(json: JSON) {
            for result in json["results"].arrayValue {
                let title = result["title"].stringValue
                let body = result["body"].stringValue
                let sigs = result["signatureCount"].stringValue
                let obj = ["title": title, "body": body, "sigs": sigs]
                petitions.append(obj)
            }/// Here we create a function called parse. It is a Struct that contains data type "Data". A for loop is then run for self in JSON, setting self title,selfbody,selfsig. It set the title and declares that it is a String. It then declare the body is a String. It then sets sigs as a String as well. These three data types are then put into the new var obj. Then the obj are then added to the Dictionary "petitions"
            
            tableView.reloadData()
        }//The table needs to be reloaded to get the updated table loaded.
        
        func showError() {
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }//This UIAlert calls an error message if there is an error. This need to be declared in the viewDidLoad() as it is called before the end of the function.
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
            
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                
                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                    parse(json: json)
                    return
                }
            }
        }
        
        showError()
}//This is the code that takes the HTML from the url. This is then translated using JSON into swift code. The code is then filtered so that it only is displayed if it has 10000 signature as well as is fully working. If in any case the entry is incorrect it will cause an error message. We use the try and the let so that if the internet is down it does not cause an error. Finally the parse function is then run with the new created json. This inturn updates the dictionary "petitions"
 //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    //This override function contains the tableView and links it with our UITableView on the mainstoryboard.
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition["title"]
        cell.detailTextLabel?.text = petition["body"]
        return cell
    //In this override function where are telling the prototype cell that the subtitle should contain the detail text.
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }// This link the detail view controller to the tableview.
}

