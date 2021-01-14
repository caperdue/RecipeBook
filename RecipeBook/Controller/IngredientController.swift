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

protocol ViewRecipeDelegate {
    func retrieveName() -> String
    func retrieveWhole() -> Int
    func retrieveNumerator() -> Int
    func retrieveSlash() -> Int
    func retrieveDenominator() -> Int
    func retrieveMeasurementType() -> Int
    func retrieveLiquidOrSolidIndex() -> Int
    func editIngredientMode() -> Bool
}

class IngredientController: UIViewController {
    
    var ingredientDelegate: IngredientVCDelegate?
    var viewDelegate: ViewRecipeDelegate?
    @IBOutlet weak var measurementType: UIPickerView!
    @IBOutlet weak var fractionPickerView: UIPickerView!
    @IBOutlet weak var addToListButton: UIButton!
    @IBOutlet weak var ingredientNameTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        measurementType.dataSource = self
        measurementType.delegate = self
        fractionPickerView.delegate = self
        fractionPickerView.dataSource = self
        addToListButton.layer.cornerRadius = 10
        self.measurementType.setValue(UIColor.white, forKeyPath: "textColor")
        self.fractionPickerView.setValue(UIColor.white, forKeyPath: "textColor")
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //If there is a viewDelegate (means that this view was tapped for editing)
        if let validDelegate = viewDelegate {
            //Set ingredient presets to recipe's ingredient
            if validDelegate.editIngredientMode() {
                ingredientNameTextField.text = validDelegate.retrieveName()
                fractionPickerView.selectRow(validDelegate.retrieveWhole(), inComponent: 0, animated: false)
                fractionPickerView.selectRow(validDelegate.retrieveNumerator(), inComponent: 1, animated: false)
                fractionPickerView.selectRow(validDelegate.retrieveSlash(), inComponent: 2, animated: false)
                fractionPickerView.selectRow(validDelegate.retrieveDenominator(), inComponent: 3, animated: false)
                segmentedControl.selectedSegmentIndex = validDelegate.retrieveLiquidOrSolidIndex()
                measurementType.selectRow(validDelegate.retrieveMeasurementType(), inComponent: 0, animated: false)
                ingredientNameTextField.alpha = 1
            }
        }
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
            ingredientNameTextField.text = Utilities.ingredientPlaceholder
            ingredientNameTextField.alpha = 0.8
        }
    }

    //Do this to refresh the available values
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        measurementType.reloadAllComponents()
    }
    
    @IBAction func addToListButtonPressed(_ sender: UIButton) {
        ingredientNameTextField.endEditing(true)
      if ingredientNameTextField.text != "" && ingredientNameTextField.text != Utilities.ingredientPlaceholder {
            var typeOfMeasurement: String = ""
            let wholeNumber = fractionPickerView.selectedRow(inComponent: 0)
            let numerator = fractionPickerView.selectedRow(inComponent: 1)
            let slash = fractionPickerView.selectedRow(inComponent: 2)
            let denominator = fractionPickerView.selectedRow(inComponent: 3)
            var liquidOrSolid: String = ""
            //Check if the ingredient is a liquid or solid
            if segmentedControl.selectedSegmentIndex == 0 {
                typeOfMeasurement = Ingredient.availableSolidMeasurements[measurementType.selectedRow(inComponent: 0)]
                liquidOrSolid = "solid"
            }
            else if segmentedControl.selectedSegmentIndex == 1 {
                typeOfMeasurement = Ingredient.availableLiquidMeasurements[measurementType.selectedRow(inComponent: 0)]
                liquidOrSolid = "liquid"
            }
        print(liquidOrSolid)
    
            //Creating the ingredient object
            let amount = Utilities.convertAmount(wholeNumber, numerator, denominator, slash == 1 ? true: false)
            do {
                let newIngredient: Ingredient = try Ingredient(name: self.ingredientNameTextField.text!, amount: amount, measurementType: typeOfMeasurement, liquidOrSolid: liquidOrSolid)
                print(liquidOrSolid)
                
                self.ingredientDelegate?.addIngredientToList(newIngredient: newIngredient)
                self.ingredientDelegate?.reloadIngredients()
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

extension IngredientController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch(pickerView.tag) {
        case 1:
            return 4
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch (pickerView.tag) {
        case 1:
            switch(component) {
            case 0:
                return 30
            case 1:
                return 30
            case 2:
                return 2
            case 3:
                return 30
            default:
                return 0
            }
        case 2:
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
            switch (component) {
            case 0:
                if row == 0 { return "-" }
                return "\(row)"
            case 1:
                if row == 0 { return "-" }
                return "\(row)"
            case 2:
                if row == 0 { return "-" }
                return "/"
            case 3:
                if row == 0 { return "-" }
                return "\(row)"
            default:
                return ""
            }
        case 2:
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
