//
//  ViewController.swift
//  project 6b
//
//  Created by Elliot Ross on 02/05/2017.
//  Copyright © 2017 Elliot Ross. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = UIColor.red
        label1.text = "THESE"
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = UIColor.cyan
        label2.text = "ARE"
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.yellow
        label3.text = "SOME"
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = UIColor.green
        label4.text = "AWESOME"
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = UIColor.orange
        label5.text = "LABELS"
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        //This is adding labels to the application and stating there colour as well as their contents. This is the code approach to adding labels whichout the use of Main.storyboard.
        
        
        
        //Using Visual-Contraints-----------------------------------------------------------------------------------------
        
        //let metrics = ["labelHeight": 88]
        //let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
        //view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label1]|", options: [], metrics: nil, views: viewsDictionary))
        //view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label2]|", options: [], metrics: nil, views: viewsDictionary))
        //view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label3]|", options: [], metrics: nil, views: viewsDictionary))
        //view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label4]|", options: [], metrics: nil, views: viewsDictionary))
        //view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label5]|", options: [], metrics: nil, views: viewsDictionary))
        //This creates a dictionary(viewsDictionary). Then the dictionary is told how to layout it contents with Visual Format's Contraints. "H:| [label4] |" The string reads add the data from the dictionary of which is labelled label 4. The H states that this is done under the horizonal contraints.
       //view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|", options: [], metrics: metrics, views: viewsDictionary))
        // This line add the vertical contraint to the layout, where as before this the labels will overlap each other. The - means add a space. This is set to the default 10 points. The first label is set to @999 which means it is optinal but at the highest priority. The other labels are then set to label one so they are all of highest priority.
//------------------------------------------------------------------------------------------------------------------------
        
        var previous: UILabel!
        
        for label in [label1, label2, label3, label4, label5] {
            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 88).isActive = true
            
            if previous != nil {
                // we have a previous label – create a height constraint
                label.topAnchor.constraint(equalTo: previous.bottomAnchor).isActive = true
            }
            
            // set the previous label to be the current one, for the next loop iteration
            previous = label
        
        
        }// This method uses anchors to do the autolayout. When using anchors we need to make sure that we know what lanuages we are using as then we need to take into account that right and trailing anchor are going to be the same.
    
    
    
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
        //This hide the status bar when in the app.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

