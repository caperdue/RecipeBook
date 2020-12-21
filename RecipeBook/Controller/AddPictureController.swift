//
//  addPictureController.swift
//  RecipeBook
//
//  Created by Carly Perdue on 12/20/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit

protocol LastRecipeDelegate {
    func getRecipeObject() -> Recipe
    
}
class AddPictureController: UIViewController {
    var steps: String = ""
    var delegate: LastRecipeDelegate?
    
    @IBOutlet weak var hourTextField: UITextField!
    @IBOutlet weak var minuteTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet var favoritesSlider: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Assigning delegates so that recipe values can be fetched between views
        
    }
    @IBAction func hourEditingBegan(_ sender: UITextField) {
        if hourTextField.text == "-" {
            hourTextField.text = ""
        }
    }
    
    @IBAction func hourEditingEnded(_ sender: UITextField) {
        if hourTextField.text == "" {
            hourTextField.text = "-"
        }
    }
    
    @IBAction func minuteEditingBegan(_ sender: UITextField) {
        if minuteTextField.text == "-" {
            minuteTextField.text = ""
        }
    }
    @IBAction func minuteEditingEnded(_ sender: UITextField) {
        if minuteTextField.text == "" {
            minuteTextField.text = "-"
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        if (minuteTextField.text != "" && minuteTextField.text != "" || (minuteTextField.text != "-" || hourTextField.text != "-")) {
            let finalRecipe = delegate?.getRecipeObject()
            finalRecipe?.setTime("\(hourTextField.text!) hr,  \(minuteTextField.text!) min")
            print(finalRecipe!)
            RecipeBook.allRecipes.append(finalRecipe!)
            //Redirect back to initial screen
            self.navigationController?.popToRootViewController(animated: true)
            
     
            
        }
    }
    
    
    
    
    
    
    
    
    
}
