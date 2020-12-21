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
   
   private var name:String? = nil
    private var ingredients:[Ingredient] = []
    private var image:UIImage? = nil
   private var amount:Int? = nil
   private var time:String? = nil
    private var steps: String? = nil
    private var recipeType: String? = nil
    
  /*
    init(name: String, ingredients: [Ingredient], image: UIImage, amount: Int, time: String, steps: String, recipeType: String) {
        self.name = name
        self.ingredients = ingredients
        self.image = image
        self.amount = amount
        self.time = time
        self.steps = steps
        self.recipeType = recipeType
    }*/
    
    //Getters and setters
    func getTime() -> String {
        return self.time ?? ""
    }
    func getRecipeName() -> String {
        return self.name ?? ""
    }
    func getImage() -> UIImage? {
        return self.image
    }
    func getIngredients() -> [Ingredient] {
        return self.ingredients
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
    func setTime(_ newTime: String) {
        self.time = newTime
    }
    func setSteps(_ newSteps: String) {
        self.steps = newSteps
    }
    func setRecipeType(_ newRecipeType: String) {
        self.recipeType = newRecipeType
    }

    func setIngredients(_ newIngredients: [Ingredient]){
        self.ingredients = newIngredients
    }
}
