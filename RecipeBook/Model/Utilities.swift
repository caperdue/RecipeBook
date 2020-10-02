//
//  Utilities.swift
//  RecipeBook
//
//  Created by Carly Perdue on 9/15/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit

enum IllegalEntryError: Error {
    case empty
    case invalidEntry
}
class Utilities {

    static func giveAnimationError(view: UIView, for duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10)
    {
   let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
        view.transform = CGAffineTransform(translationX: translation, y: 0)
    }

    propertyAnimator.addAnimations({
        view.transform = CGAffineTransform(translationX: 0, y: 0)
    }, delayFactor: 0.2)

    propertyAnimator.startAnimation()
    }
    
    static func checkIfEmpty(string: String) throws {
        if string.isEmpty {
            throw IllegalEntryError.empty
        }
        
    }
    static func convertFraction(fractionString: String) -> Float? {
        let convertedFraction = fractionString.split(separator: "/")
      
        if convertedFraction.count == 2 {
            if let numerator = Float(convertedFraction[0]), let denominator = Float(convertedFraction[1]) {
                if numerator < denominator {
                    return numerator / denominator }
            }
        }
        return nil
        }
    
    static func convertStringsToFloat(string1: String?, string2: String?) throws -> (Float)?   {
        var ingredientAmount:Float? = 0

        //If there is 1 string, handle operations
        if string1 != nil && string2 == nil && convertOneStringToFloat(string1) != nil {
            ingredientAmount = convertOneStringToFloat(string1!)!
        }
            
        //If there are 2 strings, handle operation here
        else if string1 != nil && string2 != nil && convertOneStringToFloat(string1) != nil && convertOneStringToFloat(string2) != nil  {
            ingredientAmount! += convertOneStringToFloat(string1!)!
            ingredientAmount! += convertOneStringToFloat(string2!)!
        }
        guard ingredientAmount! > 0.0 else {
            throw IllegalEntryError.invalidEntry
        }
        return ingredientAmount
       
    }
    
    static func convertOneStringToFloat(_ string: String?) -> Float? {
        if let floatIngredientAmount = Float(string!) {
            return floatIngredientAmount
        }
        
        if let fractionFloatIngredientAmount = convertFraction(fractionString: string!) {
            return fractionFloatIngredientAmount
        }
        return nil
    }
       
            
    }
