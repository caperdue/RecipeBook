//
//  StepsController.swift
//  RecipeBook
//
//  Created by Carly Perdue on 10/5/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit

class StepsController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var recipeType: UISegmentedControl!
    @IBOutlet weak var stepsTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        stepsTextView.delegate = self
        stepsTextView.textColor = UIColor.white
        stepsTextView.layer.cornerRadius = 10
        stepsTextView.textContainerInset.left = 10
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func nextPressed(_ sender: UIBarButtonItem) {
        if stepsTextView.text != Utilities.stepsPlaceholder && stepsTextView.text != "" {
            //If there is a delegate, then safely copy over the values
            stepsTextView.endEditing(true)
            RecipeBook.draftedRecipe.setSteps(stepsTextView.text!)
            RecipeBook.draftedRecipe.setRecipeType(segmentedControl.selectedSegmentIndex)
            performSegue(withIdentifier: "addPictureSegue", sender: self)
            
        }
        else {
            Utilities.showAlertMessage(vc: self, title: "Error", message: "Please enter the steps for your recipe!")
        }
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
