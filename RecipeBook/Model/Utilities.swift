//
//  Utilities.swift
//  RecipeBook
//
//  Created by Carly Perdue on 9/15/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit
import Darwin


class Utilities {
    static let ingredientPlaceholder = "E.x. Tomato sauce"
    static let recipePlaceholder = "E.x. Lasagna"
    static let stepsPlaceholder = "Begin typing here..."
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

    static func showAlertMessage(vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: "Please enter the steps for your recipe!", preferredStyle: UIAlertController.Style.alert)
        // add OK button
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func resetDraft() {
      RecipeBook.draftedRecipe = Recipe()
    }
    
    static func setCheckTime(hourTextField: UITextField, minuteTextField: UITextField) -> Bool{
        if minuteTextField.text == "-" && hourTextField.text != "-" || hourTextField.text == "-" && minuteTextField.text != "-" || minuteTextField.text != "-" && hourTextField.text != "-" {
            RecipeBook.draftedRecipe.setTime(["hr(s)": hourTextField.text! != "-" ? (Int(hourTextField.text!)!): 0, "min(s)": minuteTextField.text! != "-" ? (Int(minuteTextField.text!)!): 0])
                return true
            }
        else {
           return false
        }
    }
    
    static func convertAmount(_ wholeNumber: Int, _ numerator: Int, _ denominator: Int, _ slashPresent: Bool) -> Dictionary<String, Int>? {
        if wholeNumber != 0 {
            //Means there is a whole number and fraction present
            if numerator != 0 && denominator != 0 && slashPresent {
                //Means fraction and whole number can be converted to a whole number
                if (numerator % denominator) == 0 {
                    return ["whole": wholeNumber+(numerator/denominator), "numerator": 0, "denominator": 0]
                }
                //Means there is a whole number and fraction
                else {
                    return ["whole": wholeNumber, "numerator": numerator, "denominator": denominator]
                }
            }
            //Means that the amount is just a whole number
            else if numerator == 0 && denominator == 0 && !slashPresent {
                return ["whole": wholeNumber, "numerator": 0, "denominator":0]
            }
        }
        //Handles that there is just a fraction
        else if wholeNumber == 0 {
            if numerator != 0 && denominator != 0 && slashPresent {
                //Means sole fraction can be converted to a whole number
                if (numerator % denominator) == 0 {
                    return ["whole": wholeNumber+(numerator/denominator), "numerator": 0, "denominator":0]
                }
                //Means there is just a fraction
                else {
                    return["whole": 0, "numerator": numerator, "denominator": denominator]
                }
            }
        }
        return nil
    }
}

