//
//  File.swift
//  RecipeBook
//
//  Created by Carly Perdue on 9/12/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit

class RecipeIngredientController: UIViewController, UITableViewDelegate {
    
    var recipeName:String?
    var ingredients:[Ingredient] = []

    @IBOutlet weak var ingredientTableView: UITableView!

    @IBOutlet weak var emptyIngredientsLabel: UILabel!
    
    override func viewDidLoad() {
        ingredientTableView.dataSource = self
        ingredientTableView.delegate = self
        //FIX ME: change text to be what is registered in other VC
        ingredientTableView.register(UINib(nibName: "listCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ingredientsListToAddIngredient" {
            let destinationVC = segue.destination as! IngredientViewController
             destinationVC.delegate = self
        }
    }
}

extension RecipeIngredientController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell = ingredientTableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! listCell
        let text = "\(ingredients[indexPath.row].getAmount()) \(ingredients[indexPath.row].getMeasurementType()) \(ingredients[indexPath.row].getName())"
        cell.textLabel?.text = text
        return cell

       }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let handler: UIContextualAction.Handler = { (action: UIContextualAction, view: UIView, completionHandler: ((Bool) -> Void)) in
            self.ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        
        let deleteAction = UIContextualAction(style: UIContextualAction.Style.destructive, title: "Delete", handler: handler)
        // Add more actions here if required
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
       
}

extension RecipeIngredientController: IngredientVCDelegate {
    func removeStarterMessage(view: UIViewController) {
        if emptyIngredientsLabel.isHidden == false && ingredients.count > 0 {
            emptyIngredientsLabel.isHidden = true
        }
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
    
    func addIngredientToList(newIngredient: Ingredient) {
        ingredients.append(newIngredient)
    }
}

