//
//  StartRecipeController.swift
//  RecipeBook
//
//  Created by Carly Perdue on 9/26/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//
 
import Foundation
import UIKit

class IngredientListController: UIViewController {
    //Properties for the local recipe to passed to next controller
    var recipeName: String?
    var draftIngredients:[Ingredient] = []
    var editIngredientTapped = false
    var tappedIngredient: Ingredient?
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var ingredientTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTableView.dataSource = self
        ingredientTableView.delegate = self
        ingredientTableView.rowHeight = 40
        
        //Registering the ingredient table view with the custom cells
        ingredientTableView.register(UINib(nibName: "ingredientCell", bundle: nil), forCellReuseIdentifier: "ReusableIngredientCell")
        
        ingredientTableView.layoutMargins = UIEdgeInsets.zero
        ingredientTableView.separatorInset = UIEdgeInsets.zero
       
        //Open the keyboard to enter the name of the recipe
        recipeNameTextField.becomeFirstResponder()
    }
    
    @IBAction func recipeTextBeganEditing(_ sender: UITextField) {
        if recipeNameTextField.text!.isEmpty || recipeNameTextField.text! == "E.x. Lasagna" {
            recipeNameTextField.text = ""
            recipeNameTextField.alpha = 1
        }
    }
    @IBAction func recipeTextEndedEditing(_ sender: UITextField) {
        if recipeNameTextField.text == "" {
            recipeNameTextField.text = Utilities.recipePlaceholder
            recipeNameTextField.alpha = 0.8
        }
    }
    @IBAction func nextPressed(_ sender: UIBarButtonItem) {
        if draftIngredients.count > 0 && recipeNameTextField.text != "" && recipeNameTextField.text != Utilities.recipePlaceholder {
            var duplicates = false
            for i in RecipeBook.allRecipes {
                if i.getRecipeName() == recipeNameTextField.text {
                    duplicates = true
                }
            }
            if (!duplicates){
            //Setting the recipe object with ingredients and name
                recipeNameTextField.endEditing(true)
            RecipeBook.draftedRecipe.setIngredients(draftIngredients)
            RecipeBook.draftedRecipe.setName(recipeNameTextField.text!)
            self.performSegue(withIdentifier: "toStepsSegue", sender: self)
            }
            else {
                Utilities.showAlertMessage(vc: self, title: "Error", message: "You already have a recipe with this name!")
            }
        }
        else {
            Utilities.showAlertMessage(vc: self, title: "Error", message: "Make sure you have a name and ingredient for your recipe!")
        }
    }
    @IBAction func cancelPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addIngredientPressed(_ sender: UIButton) {
        if !recipeNameTextField.text!.isEmpty && recipeNameTextField.text != Utilities.recipePlaceholder {
            recipeNameTextField.endEditing(true)
            self.performSegue(withIdentifier: "addIngredientSegue", sender: self)
        }
        else {
            Utilities.showAlertMessage(vc: self, title: "Error", message: "Please enter a recipe name first!")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //Setting IngredientViewController delegate to here so ingredients can be added
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addIngredientSegue" {
            let destinationVC = segue.destination as! IngredientController
             destinationVC.ingredientDelegate = self
        }
    }
}
    
extension IngredientListController: IngredientVCDelegate {
    func addIngredientToList(newIngredient: Ingredient) {
            //Checks to see if user wants to edit the existing ingredient
            if !editIngredientTapped {
                draftIngredients.append(newIngredient)
            }
            //Retrieve the old ingredient object and change the values to reupdate in the table
            else {
                let wholeIndex = newIngredient.getAmount()!["whole"]!
                let numeratorIndex = newIngredient.getAmount()!["numerator"]!
                let denominatorIndex = newIngredient.getAmount()!["denominator"]!
                if let tappedIngredient = tappedIngredient {
                    tappedIngredient.setAmount(Utilities.convertAmount(wholeIndex, numeratorIndex, denominatorIndex, numeratorIndex > 0 && denominatorIndex > 0 ? true : false)!)
                    tappedIngredient.setName(newIngredient.getName()!)
                    tappedIngredient.setLiquidOrSolid(newIngredient.getLiquidOrSolid()!)
                    tappedIngredient.setMeasurementType(newIngredient.getMeasurementType()!)
                }
            }
            //Change editing mode
            editIngredientTapped = !editIngredientTapped
    }
    
    func reloadIngredients() {
        DispatchQueue.main.async {
            self.ingredientTableView.reloadData()
            if self.draftIngredients.count > 0 {
                let indexPath = IndexPath(row: self.draftIngredients.count-1, section: 0)
                self.ingredientTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
    }
}

extension IngredientListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return draftIngredients.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tappedIngredient = draftIngredients[indexPath.row]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientTableView.dequeueReusableCell(withIdentifier: "ReusableIngredientCell", for: indexPath) as! ingredientCell
        if draftIngredients.count > 0 {
        let text = draftIngredients[indexPath.row].parseAmount()
        cell.ingredientLabel.text = text
        }
        //Set cell background to be transparent programatically
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
       if editingStyle == .delete
       {
          draftIngredients.remove(at: indexPath.row)
        ingredientTableView.deleteRows(at: [indexPath], with: .fade)
       }
    }
}
