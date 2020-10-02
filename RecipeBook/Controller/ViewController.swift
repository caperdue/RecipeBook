//
//  ViewController.swift
//  RecipeBook
//
//  Created by Carly Perdue on 9/12/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    let myRecipeBook: RecipeBook = RecipeBook()
    
     @IBOutlet weak var recipeTableView: UITableView!
    
    
    @IBAction func addRecipe(_ sender: UIButton) {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeBook.allRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeTableView.dequeueReusableCell(withIdentifier: "recipeCell")!
        let text = RecipeBook.allRecipes[indexPath.row].getRecipeName()
        
        cell.textLabel?.text = text
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.dataSource = self
        
    }


}




