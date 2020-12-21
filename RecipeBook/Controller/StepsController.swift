//
//  StepsController.swift
//  RecipeBook
//
//  Created by Carly Perdue on 10/5/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit
//FIX ME: MAKE IT SO THAT DELEGATE PASSES AN OBJECT INSTEAD OF ATTRIBUTES
protocol RecipeObjectDelegate {
    func getRecipeObject() -> Recipe
    
}
class StepsController: UIViewController {
    var delegate: RecipeObjectDelegate?
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var recipeType: UISegmentedControl!
    @IBOutlet weak var stepsTextView: UITextView!
    var updatedRecipe: Recipe = Recipe()
    override func viewDidLoad() {
        super.viewDidLoad()
        stepsTextView.delegate = self
        stepsTextView.textColor = UIColor.white
        stepsTextView.layer.cornerRadius = 10
        stepsTextView.textContainerInset.left = 10
    }
    
    
    @IBAction func nextPressed(_ sender: UIBarButtonItem) {
        if stepsTextView.text != Utilities.stepsPlaceholder && stepsTextView.text != "" {
            //If there is a delegate, then safely copy over the values
            stepsTextView.endEditing(true)
            updatedRecipe = (delegate?.getRecipeObject())!
                updatedRecipe.setSteps(stepsTextView.text!)
                updatedRecipe.setRecipeType(segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)!)
            
                performSegue(withIdentifier: "addPictureSegue", sender: self)
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPictureSegue" {
            let destinationVC = segue.destination as! AddPictureController
             destinationVC.delegate = self
        }
    }
}

extension StepsController:  LastRecipeDelegate {
    func getRecipeObject() -> Recipe {
        return updatedRecipe
    }
    
    
}

extension StepsController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if stepsTextView.text == Utilities.stepsPlaceholder {
            stepsTextView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if stepsTextView.text == "" {
            stepsTextView.text = Utilities.stepsPlaceholder
        }
    }
}









