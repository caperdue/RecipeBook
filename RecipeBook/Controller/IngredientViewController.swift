//
//  IngredientViewController.swift
//  RecipeBook
//
//  Created by Carly Perdue on 9/13/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//
import Foundation
import UIKit

protocol IngredientVCDelegate {
    func addIngredientToList(newIngredient: Ingredient)
    func reloadIngredients()
}


class IngredientViewController: UIViewController {
    var delegate: IngredientVCDelegate?
    @IBOutlet weak var measurementType: UIPickerView!
    @IBOutlet weak var wholeNumPickerView: UIPickerView!
    @IBOutlet weak var fractionPickerView: UIPickerView!
    @IBOutlet weak var addToListButton: UIButton!
    @IBOutlet weak var ingredientNameTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad(){
        super.viewDidLoad()
        measurementType.dataSource = self
        measurementType.delegate = self
        wholeNumPickerView.dataSource = self
        wholeNumPickerView.delegate = self
        fractionPickerView.delegate = self
        fractionPickerView.dataSource = self
        
        addToListButton.layer.cornerRadius = 10
        
        self.measurementType.setValue(UIColor.white, forKeyPath: "textColor")
        self.wholeNumPickerView.setValue(UIColor.white, forKeyPath: "textColor")
        self.fractionPickerView.setValue(UIColor.white, forKeyPath: "textColor")
  
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func ingredientEditBegan(_ sender: UITextField) {
        ingredientNameTextField.text = ""
        ingredientNameTextField.alpha = 1
    }
    
    @IBAction func ingredientEditEnded(_ sender: UITextField) {
        if ingredientNameTextField.text == "" {
            ingredientNameTextField.text = "E.x. Chocolate Chips"
            ingredientNameTextField.alpha = 0.8
        }
    }

    //Do this to refresh the available values
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        measurementType.reloadAllComponents()
    }
    //FIX me
    @IBAction func addToListButtonPressed(_ sender: UIButton) {
      if ingredientNameTextField.text != "" && ingredientNameTextField.text != Utilities.ingredientPlaceholder {
            var amount:String?
            var typeOfMeasurement: String = ""
            let numerator = fractionPickerView.selectedRow(inComponent: 0)
            let slash = fractionPickerView.selectedRow(inComponent: 1)
            let denominator = fractionPickerView.selectedRow(inComponent: 2)
            var wholeNumber = wholeNumPickerView.selectedRow(inComponent: 0)
            
            //Handles cases that there is a whole number present
            if wholeNumber != 0 {
                //Means there is a whole number and fraction present
                if numerator != 0 && denominator != 0 && slash == 1 {
                    if (numerator % denominator) == 0 {
                        wholeNumber = wholeNumber + (numerator/denominator)
                        amount = ("\(wholeNumber)")
                    }
                    else {
                    amount = "\(wholeNumber) \(numerator)/\(denominator)"
                    }
                }
                //Means that the amount is just a whole number
                else if numerator == 0 && denominator == 0 && slash == 0 {
                    amount = ("\(wholeNumber)")
                }
            }
            //Handles that there is just a fraction
            else if wholeNumber == 0 {
                if numerator != 0 && denominator != 0 && slash == 1 {
                    if (numerator % denominator) == 0 {
                        wholeNumber = wholeNumber + (numerator/denominator)
                        amount = ("\(wholeNumber)")
                    }
                    else {
                        amount = "\(numerator)/\(denominator)"
                    }
                }
            }
            
            //Check if the ingredient is a liquid or solid
            if segmentedControl.selectedSegmentIndex == 0 {
                typeOfMeasurement = Ingredient.availableSolidMeasurements[measurementType.selectedRow(inComponent: 0)]
            }
            else if segmentedControl.selectedSegmentIndex == 1 {
                typeOfMeasurement = Ingredient.availableLiquidMeasurements[measurementType.selectedRow(inComponent: 0)]
            }
            
            
            //Creating the ingredient object
            do {
                let newIngredient: Ingredient = try Ingredient(name: self.ingredientNameTextField.text!, amount: amount ?? "", measurementType: typeOfMeasurement)
                
                print(newIngredient)
                self.delegate?.addIngredientToList(newIngredient: newIngredient)
                self.delegate?.reloadIngredients()
                navigationController?.popViewController(animated: true)
                dismiss(animated: true, completion: nil)
                
                
            }

            catch IllegalEntryError.illegalAmount {
                Utilities.giveAnimationError(view: addToListButton)
        
            }
            
            catch {
                Utilities.giveAnimationError(view: addToListButton)
            }
            
        }
    }
    }

extension IngredientViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch(pickerView.tag) {
        case 1:
            return 1
        case 2:
            return 3
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Handling so that the user doesn't enter an invalid value
        //If user has a number chosen in the fraction, automatically add the slash
        if pickerView.tag == 2 && row != 0 && (component == 0 || component == 2) {
            fractionPickerView.selectRow(1, inComponent: 1, animated: true)
        }
        
        //Reset all values if user sets any fraction to nothing in any column
        else if (pickerView.tag == 2 && row == 0) {
            fractionPickerView.selectRow(0, inComponent: 0, animated: true)
            fractionPickerView.selectRow(0, inComponent: 1, animated: true)
            fractionPickerView.selectRow(0, inComponent: 2, animated: true)
        }
        
        }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch (pickerView.tag) {
        case 1:
            return 30
            
        case 2:
            switch(component) {
            case 0:
                return 30
            case 1:
                return 2
            case 2:
                return 30
            default:
                return 0
            }
        case 3:
            if segmentedControl.selectedSegmentIndex == 0 {
                return Ingredient.availableSolidMeasurements.count
            }
            else if segmentedControl.selectedSegmentIndex == 1 {
                return Ingredient.availableLiquidMeasurements.count
            }
        default:
            return 0
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch (pickerView.tag) {
        case 1:
            if row == 0 { return "-"}
            return "\(row)"
        case 2:
            switch (component) {
            case 0:
                if row == 0 { return "-" }
                return "\(row)"
            case 1:
                if row == 0 { return "-" }
                return "/"
            case 2:
                if row == 0 { return "-" }
                return "\(row)"
            default:
                return ""
            }
        case 3:
            if segmentedControl.selectedSegmentIndex == 0 {
                return Ingredient.availableSolidMeasurements[row]
            }
            else if segmentedControl.selectedSegmentIndex == 1 {
                return Ingredient.availableLiquidMeasurements[row]
            }
        default:
            return ""
    }
        return ""
    }

}
