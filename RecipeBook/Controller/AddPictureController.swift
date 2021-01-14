//
//  addPictureController.swift
//  RecipeBook
//
//  Created by Carly Perdue on 12/20/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit

class AddPictureController: UIViewController {
    var steps: String = ""
    
    @IBOutlet weak var hourTextField: UITextField!
    @IBOutlet weak var minuteTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var favoritesSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Assigning delegates so that recipe values can be fetched between views
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
        minuteTextField.endEditing(true)
        hourTextField.endEditing(true)
        if (Utilities.setCheckTime(hourTextField: hourTextField, minuteTextField: minuteTextField)) {
            RecipeBook.draftedRecipe.setFavorite(favoritesSwitch.isOn)
            performSegue(withIdentifier: "editPhotoSegue", sender: self)
        }
        else {
            Utilities.showAlertMessage(vc: self, title: "Error", message: "Please enter a valid time!")
        }
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
        minuteTextField.endEditing(true)
        hourTextField.endEditing(true)
        if Utilities.setCheckTime(hourTextField: hourTextField, minuteTextField: minuteTextField) {
            RecipeBook.draftedRecipe.setFavorite(favoritesSwitch.isOn)
            let finalRecipe = RecipeBook.draftedRecipe
            RecipeBook.allRecipes.append(finalRecipe)
            //Redirect back to initial screen
            self.navigationController?.popToRootViewController(animated: true)
        }
        else {
            Utilities.showAlertMessage(vc: self, title: "Error", message: "Please enter a valid time!")
        }
    }
}
