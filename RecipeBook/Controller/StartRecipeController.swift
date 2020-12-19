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
    var recipeName: String?
    var ingredients:[Ingredient] = []


    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var ingredientTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientTableView.dataSource = self
        ingredientTableView.delegate = self
        ingredientTableView.rowHeight = 40

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
            Utilities.giveAnimationError(view: recipeNameTextField, for: 0.5, withTranslation: 10)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //Setting IngredientViewController delegate to here so ingredients can be added
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addIngredientSegue" {
            let destinationVC = segue.destination as! IngredientViewController
             destinationVC.delegate = self
        }
    }
}

extension StartRecipeController: IngredientVCDelegate {
    func addIngredientToList(newIngredient: Ingredient) {
        ingredients.append(newIngredient)
    }
    
    func reloadIngredients() {
        DispatchQueue.main.async {
            self.ingredientTableView.reloadData()
            if self.ingredients.count > 0 {
                let indexPath = IndexPath(row: self.ingredients.count-1, section: 0)
                self.ingredientTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
    }
}

extension StartRecipeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientTableView.dequeueReusableCell(withIdentifier: "ReusableIngredientCell", for: indexPath) as! ingredientCell
        
        if ingredients.count > 0 {
        let text = "\(ingredients[indexPath.row].getAmount()) \(ingredients[indexPath.row].getMeasurementType()) \(ingredients[indexPath.row].getName())"
        cell.ingredientLabel.text = text
        }
        //Set cell background to be transparent programatically
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    
}
