//
//  StepsController.swift
//  RecipeBook
//
//  Created by Carly Perdue on 10/5/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit

//Fix to add so that cell is notified when the add button is pressed to dismiss editing.
class StepsController: UIViewController {
    @IBOutlet weak var recipeType: UISegmentedControl!
    
    @IBOutlet weak var stepsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepsTextView.layer.cornerRadius = 10
    }
    
    @IBAction func valueChanged(_ sender: UISegmentedControl) {
    }
    
}









