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

    override func viewDidLoad() {
        ingredientTableView.dataSource = self
        ingredientTableView.delegate = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
           
        let cell = ingredientTableView.dequeueReusableCell(withIdentifier: "ingredientCell")!
        let text = "\(ingredients[indexPath.row].getName())"
        
        cell.textLabel?.text = text
        return cell

       }
       
}

extension RecipeIngredientController: IngredientVCDelegate {
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

