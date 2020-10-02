//
//  Recipe.swift
//  RecipeBook
//
//  Created by Carly Perdue on 9/12/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit

protocol RecipeDelegate {
    func addIngredient(ingredient: Ingredient)
    
}

struct Recipe {
   
   private var name:String
   //private var numSteps:Int
   private var ingredients:[Ingredient]
   private var image:UIImage?
   private var amount: [String]?
    
   var delegate: RecipeDelegate?
    
    init(name: String, ingredients: [Ingredient], image: UIImage?) {
        self.name = name
       // self.numSteps = numSteps
        self.ingredients = ingredients
        self.image = image
        
    }
    
    mutating func addIngredientToRecipe(ingredient: Ingredient){
        ingredients.append(ingredient)
    }
    
    func getRecipeName() -> String {
        return self.name
    }
    
    func getImage() -> UIImage? {
        return self.image
    }
    
    func getIngredients() -> [Ingredient] {
        return self.ingredients
    }

}
