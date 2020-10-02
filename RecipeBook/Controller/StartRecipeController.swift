//
//  StartRecipeController.swift
//  RecipeBook
//
//  Created by Carly Perdue on 9/26/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit

class StartRecipeController: UIViewController {

    
    @IBOutlet weak var goToIngredientButton: UIButton!
   
    @IBOutlet weak var recipeNameTextField: UITextField!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func gotToIngredientButtonPressed(_ sender: UIButton) {
        if !recipeNameTextField.text!.isEmpty {
            self.performSegue(withIdentifier: "startToIngredientsList", sender: self)
            
        }
        else {
            Utilities.giveAnimationError(view: recipeNameTextField, for: 0.5, withTranslation: 10)
        }
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               
           // Create a variable to store the name the user entered on textField
               
           // Create a new variable to store the instance of the SecondViewController
           // set the variable from the SecondViewController that will receive the data
        
        if segue.identifier == "startToIngredientsList" {
            let destinationVC = segue.destination as! RecipeIngredientController
            destinationVC.recipeName = recipeNameTextField.text
            
        }
    }
}
