//
//  Recipe.swift
//  RecipeBook
//
//  Created by Carly Perdue on 9/12/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit


class Recipe {
   
    private var name:String?
    private var ingredients:[Ingredient] = []
    private var image:UIImage?
    private var amount:Int?
    private var time: Dictionary<String, Int>?
    private var steps: String?
    private var recipeType: Int?
    private var favorite:Bool?
    
    //Getters and setters
    func parseTime() -> String {
        if let validTime = self.time ?? nil {
            var newString = ""
            if validTime["hr(s)"] == 0 {
                newString = "\(String(describing: validTime["min(s)"]!)) min"
            }
            else if validTime["min(s)"] == 0 {
                newString = "\(String(describing: validTime["hr(s)"]!)) hr"
            }
            else {
            newString = "\(String(describing: validTime["hr(s)"]!)) hr, \(String(describing: validTime["min(s)"]!)) min"
            }
            return newString

        }
        return "Error"
    }
    
    func removeIngredientAtIndex(_ ingredientIndex: Int) {
        self.ingredients.remove(at: ingredientIndex)
    }
    func getTime() -> Dictionary<String, Int>? {
        return self.time
    }
    func getRecipeName() -> String? {
        return self.name
    }
    func getImage() -> UIImage? {
        return self.image
    }
    func getIngredients() -> [Ingredient] {
        return self.ingredients
    }
    func getFavorite() -> Bool? {
        return self.favorite
    }
    func getSteps() ->String? {
        return self.steps
    }
    func getRecipeType() -> Int? {
        return self.recipeType
    }
    func setName(_ newName: String) {
        self.name = newName
    }
    func setAmount(_ newAmount: Int) {
        self.amount = newAmount
    }
    func setImage(_ newImage: UIImage) {
        self.image = newImage
    }
    func setTime(_ newTime: Dictionary<String, Int>) {
        self.time = newTime
    }
    func setSteps(_ newSteps: String) {
        self.steps = newSteps
    }
    func setRecipeType(_ newRecipeType: Int) {
        self.recipeType = newRecipeType
    }

    func setIngredients(_ newIngredients: [Ingredient]){
        self.ingredients = newIngredients
    }
    func setFavorite(_ newFavorite: Bool) {
        self.favorite = newFavorite
    }
    func addIngredient(_ newIngredient: Ingredient) {
        self.ingredients.append(newIngredient)
    }
}
