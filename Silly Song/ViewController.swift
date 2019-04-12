//
//  ViewController.swift
//  Silly Song
//
//  Created by JiangXiaoxuan on 29/1/18.
//  Copyright © 2018 JiangXiaoxuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }
    
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        let fullName = nameField.text!
        lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: fullName)
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

func shortNameForName(name: String) -> String {
    let lowerName = name.lowercased()
    let vowelCharacters = CharacterSet(charactersIn: "aeiou")
    let firstVowelRange = lowerName.rangeOfCharacter(from: vowelCharacters)
    if (firstVowelRange == nil) {
        return lowerName
    }
    let start = firstVowelRange?.lowerBound;
    return lowerName.substring(from: start!)
}

func lyricsForName (lyricsTemplate: String, fullName: String) ->String{
    if fullName.isEmpty {
        return "Please provide a name."
    }
    
    let shortName = shortNameForName(name: fullName)
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    return lyrics
}

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")
