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
    
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.layer.cornerRadius = 10
    }
    
    @IBAction func gotToIngredientButtonPressed(_ sender: UIButton) {
        if !recipeNameTextField.text!.isEmpty {
            self.performSegue(withIdentifier: "startToIngredientsList", sender: self)
            
        }
        else {
            Utilities.giveAnimationError(view: recipeNameTextField, for: 0.5, withTranslation: 10)
        }
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        if segue.identifier == "startToIngredientsList" {
            let destinationVC = segue.destination as! RecipeIngredientController
            destinationVC.recipeName = recipeNameTextField.text
            
        }
    }
}
