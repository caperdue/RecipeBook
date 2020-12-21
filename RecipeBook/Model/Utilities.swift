//
//  Utilities.swift
//  RecipeBook
//
//  Created by Carly Perdue on 9/15/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit


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

}
