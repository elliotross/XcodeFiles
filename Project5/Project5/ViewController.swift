//
//  ViewController.swift
//  Project5
//
//  Created by Elliot Ross on 27/04/2017.
//  Copyright © 2017 Elliot Ross. All rights reserved.
//

//-----------------------------IMPORTS AND VARIABLES------------------------------------------------------------------------------------------------

import UIKit
import GameplayKit
var allWords = [String]()
var usedWords = [String]()
// This is where the variables and kits are loaded so swift know what it is working with

class ViewController: UITableViewController {
//This the definition of the class ViewController.
    
    //-----------------------------VIEW-DID-LOAD()------------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        //This is where the naivgation controller from main.storyboard is directed.
        
        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") { //This tell swift where to find the text file to work with(Bundle)
            if let startWords = try? String(contentsOfFile: startWordsPath) {
                allWords = startWords.components(separatedBy: "\n")
            }//This tell swift that each word is separated by "\n"
        } else {
            allWords = ["silkworm"]
        }
        startGame() //This calls the start game function of what is defined further below
        
        func submit(answer: String) { //This function checks that the entered word is correct and changes all the entered works to lowercase()
            let lowerAnswer = answer.lowercased()
            
            if isPossible(word: lowerAnswer) {
                if isOriginal(word: lowerAnswer) {
                    if isReal(word: lowerAnswer) {
                        usedWords.insert(answer, at: 0) //If the UserAnswer passes all the nested if statements then insert at 0 placed indent in the usedwords array.
                        
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic) // This then inserts a new row at 0,0. This done this way rather than a simple reload(). This is done as it is eaiser on the device memory and so that it us visable to the USER that their answer is accepted and correct. This is a visable
                    }
                }
            }
        }
       
    } //<<--This is the end of the ViewDidLoad
    
   
    
//---------VALIDATION-PROCESS--------------------------------------------------------------------------------------------------------------------------------
    
    
    func isPossible(word: String) -> Bool {
        var tempWord = title!.lowercased()
        
        for letter in word.characters {
            if let pos = tempWord.range(of: String(letter)) {
                tempWord.remove(at: pos.lowerBound)
            } else {
                return false
            }
        }
        
        return true
    
    }//Is the UsersAnswer able to be made from the title word. To do this we use a for loop combined with an if statement to run thorugh the letters in the title and if it is in there remove it from the tempWord. Then continue the for loop. If any of the letters in not in the titleWord then return false.
  
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
        //Is the UsersAnswer already used. This read return not(!) userWords contains (word:String) if so return true. There for equals if userWords does not contain the UserAnswer then return true.
    }
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }//This function uses the built in UI function TextChecker. This is built in to show spelling mistakes in user input. NSMakeRange gives to values 0 for the start position and n for the range of the word. This allows the String to be examined. The third let statement tell us where the mispelled work occurs. The final line states if the location of the misspelled range is == NSNotFound then return true. NSNotFound is the nil value for NSRange so is there is no location at where the spelling mistake is then the function will return nil which is stated as a True function. The Final return statement could of been writen in this from but for simplicity it was not. ->>if misspelledRange.location == NSNotFound { \n return true \n } else { \n return false}
    
    
 //---------INPUT-FUNCTIONS---------------------------------------------------------------------------------------------------------------------------------------
    
    func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField() //This uses the UI ALERT field to ask for user input. It has the text "ENTER ANSWER"
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] (action: UIAlertAction) in
            let answer = ac.textFields![0]
            self.submit(answer: answer.text!) //This is the sumbitting of the user input field from "ac"(above). This force unwraps the input. It submits itself to the function "submit" for validate the answer.
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true) //This is the action to be taken from the let function. This only is added if the the returned value from the function submit is True.
    }
    
    
    func startGame() {
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
        title = allWords[0]
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
        //This is the function for the startgame. It takes the list of words and shuffles them. It then set the shuffled first word"[0]" and puts it as the title of the game[line2].The values are removed form the array usedwords as the answers are going to be stored in there[line3]. The last line relaod the data in the table. This is done to make sure all the data is loaded correctly.
    }
    
    func submit(answer: String) {
        let lowerAnswer = answer.lowercased()
        
        let errorTitle: String
        let errorMessage: String
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                } else {
                    errorTitle = "Word not recognised"
                    errorMessage = "You can't just make them up, you know!"
                }
            } else {
                errorTitle = "Word used already"
                errorMessage = "Be more original!"
            }
        } else {
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from '\(title!.lowercased())'!"
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    } //This function is the actions that need to be passed for a word to be accepted into the answers. This also contains the error messages for the user if input is not correct. The functions are defined below.
    
    
    //-----------------------------FUNCTION-OVERIDE-CONTENTS------------------------------------------------------------------------------------------------
    //This is the function overides contents. This should be done after everything else is loaded so they load correctly before they get overiden.
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count //This is the function returns a value for the number of words in userwords. This is useful once the game has started to count the players score.
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
        //This function tells the UITableview that the cells are going to be filled by the components in the array usedwords. This will be the verified correct answer the user eneters.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

