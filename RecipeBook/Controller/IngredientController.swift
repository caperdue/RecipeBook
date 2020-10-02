//
//  IngredientController.swift
//  RecipeBook
//
//  Created by Carly Perdue on 9/13/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit

class IngredientController: UIViewController {
    @IBOutlet weak var measurementType: UIPickerView!
    
    override func viewDidLoad(){
        measurementType.dataSource = self
        measurementType.delegate = self
        
        
    }
    


}

extension IngredientController: UIPickerViewDataSource, UIPickerViewDelegate {
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch (component){
        case 0:
            return Ingredient.availableSolidMeasurements[row]
            
        case 1:
            return Ingredient.availableLiquidMeasurements[row]
        
        default:
            return ""
            
        }
    }
    
    
    
    
}
