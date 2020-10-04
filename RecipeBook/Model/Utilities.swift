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
    
    static func convertStringsToFloat(strings: [String.SubSequence]?) throws -> (Float)?   {
        var ingredientAmount:Float? = 0

        //If there is 1 string, handle operations
        if strings!.count > 2 {
            throw IllegalEntryError.invalidEntry
        }
        
        else if strings!.count == 1 {
            if let validString1 = convertWholeNumberToFloat(String(strings![0])) {
                ingredientAmount = validString1
            }
            if let validString1 = convertFraction(fractionString: String(strings![0])) {
                ingredientAmount = validString1
            }
            
        }
            
        //If there are 2 strings, handle operation here
        else if strings!.count == 2  {
            if let validString1 = convertWholeNumberToFloat(String(strings![0])), let validString2 = convertFraction(fractionString: String(strings![1])) {
        
                ingredientAmount! += validString1
                ingredientAmount! += validString2
                }
        }
        
        guard ingredientAmount != nil && ingredientAmount! != 0 else {
            print("ran here")
            throw IllegalEntryError.invalidEntry
        }
        return ingredientAmount
       
    }
    
    
    static func convertWholeNumberToFloat(_ string: String?) -> Float? {
        
        if let ingredientAmount = Float(string!) {
            //Make sure float conversion is greater than 0 (whole number)
            if ingredientAmount > 0.0 {
                return ingredientAmount
            }
        }
        
        //Happens if string cannot be converted to a whole number
        return nil
 
    }
}
