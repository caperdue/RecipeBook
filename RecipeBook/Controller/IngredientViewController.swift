//
//  IngredientViewController.swift
//  RecipeBook
//
//  Created by Carly Perdue on 9/13/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

protocol IngredientVCDelegate {
    func addIngredientToList(newIngredient: Ingredient)
    func reloadIngredients()
}

import Foundation
import UIKit

class IngredientViewController: UIViewController {

    var recipeName: String?
    var delegate: IngredientVCDelegate?
    @IBOutlet weak var measurementType: UIPickerView!
    @IBOutlet weak var solidButton: UIButton!
    @IBOutlet weak var liquidButton: UIButton!
    @IBOutlet weak var addToListButton: UIButton!
   
    @IBOutlet weak var ingredientNameTextField: UITextField!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    override func viewDidLoad(){
        liquidButton.isSelected = false
        solidButton.isSelected = true
        
        liquidButton.layer.cornerRadius = 10
        solidButton.layer.cornerRadius = 10
        
        measurementType.dataSource = self
        measurementType.delegate = self
  
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
        
    
    
    @IBAction func solidLiquidPressed(_ sender: UIButton) {
  
        measurementType.reloadAllComponents()
        
        liquidButton.isSelected = false
        solidButton.isSelected = false
        
        switch (sender){
        
        case liquidButton:
            liquidButton.isSelected = true
            solidButton.alpha = 0.35
            liquidButton.alpha = 1
            
        case solidButton:
            solidButton.isSelected = true
            solidButton.alpha = 1
            liquidButton.alpha = 0.35
            
        default:
            break
        
        }
    }
    
    @IBAction func addToListButtonPressed(_ sender: UIButton) {
        var typeOfMeasurement:String
        
        //Check which button is selected for measurement type
        if solidButton.isSelected {
            typeOfMeasurement = Ingredient.availableSolidMeasurements[measurementType.selectedRow(inComponent: 0)]
        }
        else {
            typeOfMeasurement = Ingredient.availableLiquidMeasurements[measurementType.selectedRow(inComponent: 0)]
        }
     /*   if ingredientNameTextField.text!.isEmpty {
            throw IllegalEntryError.empty
        }*/
        
        do {
        
        try Utilities.checkIfEmpty(string: ingredientNameTextField.text!)
        
            let amountSplit = amountTextField.text?.split(separator: " ")
        
       
            
        switch (amountSplit?.count) {
            case 1:
                _ = try Utilities.convertStringsToFloat(string1: String(amountSplit![0]), string2: nil)

            case 2:
                _ = try Utilities.convertStringsToFloat(string1: String(amountSplit![0]), string2: String(amountSplit![1]))

            
            default:
                print("error")
            }
            
        
        let ingredient = Ingredient(name: ingredientNameTextField.text!, amount: amountTextField.text!, measurementType: typeOfMeasurement)
            
        delegate?.addIngredientToList(newIngredient: ingredient)
            //added comment
        //Reload ingredients here for quick update in TableView
        delegate?.reloadIngredients()
            
        print(ingredient)
            
        //Navigate back to previous controller
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        }
        catch {
            
            Utilities.giveAnimationError(view: addToListButton, for: 0.3, withTranslation: 10)
        }

    }
}

extension IngredientViewController: UIPickerViewDataSource, UIPickerViewDelegate {
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (solidButton.isSelected){
            return Ingredient.availableSolidMeasurements.count
            
        }
            
        
        else if (liquidButton.isSelected){
            return Ingredient.availableLiquidMeasurements.count
            
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (solidButton.isSelected){
            return Ingredient.availableSolidMeasurements[row]
            
        }
            
        
        else if (liquidButton.isSelected) {
            return Ingredient.availableLiquidMeasurements[row]
            
        }
        return ""
    }
    
    
    
    
}
