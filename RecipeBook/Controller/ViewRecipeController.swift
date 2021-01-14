//
//  ViewRecipeController.swift
//  RecipeBook
//
//  Created by Carly Perdue on 1/5/21.
//  Copyright © 2021 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit
protocol RecipeViewDelegate {
    func retrieveRecipe() -> Recipe
    
}
class ViewRecipeController: UIViewController {
    var delegate: RecipeViewDelegate?
    var editedRecipe = Recipe()
    var editedIngredient = Ingredient()
    var splitAmount:[String]?
    var editIngredientTapped = false
    var newName = ""
    var slashPresent = false
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var hourTextField: UITextField!
    @IBOutlet weak var minuteTextField: UITextField!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var stepsTextView: UITextView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var recipeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        stepsTextView.delegate = self
        imagePicker.delegate = self
        ingredientsTableView.register(UINib(nibName: "ingredientCell", bundle: nil), forCellReuseIdentifier: "ReusableIngredientCell")
        editedRecipe = (delegate?.retrieveRecipe())!
        
        //UI stuff
        stepsTextView.layer.cornerRadius = 10
        stepsTextView.textColor = .white
        recipeImage.layer.cornerRadius = 10
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let validDelegate = delegate {
            recipeImage.image = validDelegate.retrieveRecipe().getImage()
            hourTextField.text = "\(String(describing: validDelegate.retrieveRecipe().getTime()!["hr(s)"]!))"
            minuteTextField.text = "\(String(describing: validDelegate.retrieveRecipe().getTime()!["min(s)"]!))"
            favoritesButton.isSelected = validDelegate.retrieveRecipe().getFavorite() ?? false
            stepsTextView.text = validDelegate.retrieveRecipe().getSteps()
            segmentedControl.selectedSegmentIndex = validDelegate.retrieveRecipe().getRecipeType() ?? 0
            recipeTextField.text = validDelegate.retrieveRecipe().getRecipeName()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editIngredientSegue" {
            let destinationVC = segue.destination as! IngredientController
            destinationVC.ingredientDelegate = self
            destinationVC.viewDelegate = self
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func addIngredientTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "editIngredientSegue", sender: self)
        
    }
    
    @IBAction func favoriteTapped(_ sender: UIButton) {
        favoritesButton.isSelected = !favoritesButton.isSelected
        editedRecipe.setFavorite(favoritesButton.isSelected)
        
    }
    @IBAction func recipeNameEndEditing(_ sender: UITextField) {
        if recipeTextField.text != "" {
            editedRecipe.setName(recipeTextField.text!)
        }
    }
    @IBAction func changeButtonTapped(_ sender: UIButton) {
       //Give a popup to add a new picture
        let alert = UIAlertController(title: title, message: "Would you like to add a picture from camera or gallery?", preferredStyle: UIAlertController.Style.alert)
        // add features
        alert.addAction(UIAlertAction(title: "Take a photo from camera", style: UIAlertAction.Style.default, handler: {_ in
            self.imagePicker.sourceType = .camera
            self.navigationController?.present(self.imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Take a photo from library", style: UIAlertAction.Style.default, handler: {_ in
            self.imagePicker.sourceType = .photoLibrary
            self.navigationController?.present(self.imagePicker, animated: true, completion:nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func hourTextFieldEndEditing(_ sender: UITextField) {
        editedRecipe.setTime(["hr(s)": Int(hourTextField.text!)!, "min(s)": editedRecipe.getTime()!["min(s)"]!])
        
    }
    @IBAction func minuteTextFieldEndEditing(_ sender: UITextField) {
        editedRecipe.setTime(["hr(s)": editedRecipe.getTime()!["hr(s)"]!, "min(s)": Int(minuteTextField.text!)!])
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        editedRecipe.setRecipeType(segmentedControl.selectedSegmentIndex)
    }
}

extension ViewRecipeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let ingredient = delegate?.retrieveRecipe().getIngredients()[indexPath.row]{
            //If user taps an ingredient cell, mark the mode for editing
            editIngredientTapped = true
            editedIngredient = ingredient
        }
        performSegue(withIdentifier: "editIngredientSegue", sender: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let validRecipe = delegate?.retrieveRecipe() {
            return validRecipe.getIngredients().count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let validRecipe = delegate?.retrieveRecipe()
        let cell = ingredientsTableView.dequeueReusableCell(withIdentifier: "ReusableIngredientCell", for: indexPath) as! ingredientCell
        if validRecipe?.getIngredients().count ?? 0 > 0 {
            let ingredients = validRecipe?.getIngredients()
            let text = "\(ingredients![indexPath.row].parseAmount())"
            cell.ingredientLabel.text = text
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
       if editingStyle == .delete
       {
         editedRecipe.removeIngredientAtIndex(indexPath.row)
         ingredientsTableView.deleteRows(at: [indexPath], with: .fade)
       }
    }
}
extension ViewRecipeController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            self.recipeImage.image = image
            self.recipeImage.contentMode = .scaleAspectFill

        }
    }
}
extension ViewRecipeController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        editedRecipe.setSteps(stepsTextView.text)
    }
    
    
}
extension ViewRecipeController: IngredientVCDelegate, ViewRecipeDelegate{
    func editIngredientMode() -> Bool {
        return editIngredientTapped
    }
    
    func retrieveName() -> String {
        return editedIngredient.getName()!
    }
    
    func retrieveWhole() -> Int {
        editedIngredient.getAmount()!["whole"]!
    }
    
    func retrieveNumerator() -> Int {
        editedIngredient.getAmount()!["numerator"]!
    }
    
    func retrieveSlash() -> Int {
        let numeratorIndex = editedIngredient.getAmount()!["numerator"]!
        let denominatorIndex = editedIngredient.getAmount()!["denominator"]!
        return numeratorIndex > 0 && denominatorIndex > 0 ? 1:0
    }
    
    func retrieveDenominator() -> Int {
        return editedIngredient.getAmount()!["denominator"]!
    }
    func retrieveLiquidOrSolidIndex() -> Int {
        return editedIngredient.getLiquidOrSolid() == "solid" ? 0 : 1
    }
    
    func retrieveMeasurementType() -> Int {
        if editedIngredient.getLiquidOrSolid() == "solid" {
            for index in 0..<Ingredient.availableSolidMeasurements.count {
                if Ingredient.availableSolidMeasurements[index] == editedIngredient.getMeasurementType() {
                    return index
                }
            }
        }
        else {
            for index in 0..<Ingredient.availableLiquidMeasurements.count {
                if Ingredient.availableLiquidMeasurements[index] == editedIngredient.getMeasurementType() {
                    return index
                }
            }
        }
        return -1
    }
    
    func addIngredientToList(newIngredient: Ingredient) {
        if let validRecipe = delegate?.retrieveRecipe() {
            //Checks to see if user wants to edit the existing ingredient
            if !editIngredientTapped {
                validRecipe.addIngredient(newIngredient)
            }
            //Retrieve the old ingredient object and change the values to reupdate in the table
            else {
                let wholeIndex = newIngredient.getAmount()!["whole"]!
                let numeratorIndex = newIngredient.getAmount()!["numerator"]!
                let denominatorIndex = newIngredient.getAmount()!["denominator"]!
                editedIngredient.setAmount(Utilities.convertAmount(wholeIndex, numeratorIndex, denominatorIndex, numeratorIndex > 0 && denominatorIndex > 0 ? true : false)!)
                editedIngredient.setName(newIngredient.getName()!)
                editedIngredient.setLiquidOrSolid(newIngredient.getLiquidOrSolid()!)
                editedIngredient.setMeasurementType(newIngredient.getMeasurementType()!)
            }
            //Change editing mode
            editIngredientTapped = !editIngredientTapped
        }
    }
    
    func reloadIngredients() {
        DispatchQueue.main.async {
            self.ingredientsTableView.reloadData()
            if self.editedRecipe.getIngredients().count > 0 {
                let indexPath = IndexPath(row: self.editedRecipe.getIngredients().count-1, section: 0)
                self.ingredientsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
    }
}
