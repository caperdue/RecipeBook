//
//  EditPictureController.swift
//  RecipeBook
//
//  Created by Carly Perdue on 1/3/21.
//  Copyright © 2021 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit

class EditPictureController: UIViewController {
    var photoTaken = false
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var recipeImage: UIImageView!
    var takenImage: UIImage?
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var libraryButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        if photoTaken {
        if let validImage = takenImage {
        RecipeBook.draftedRecipe.setImage(validImage)
            let finalRecipe = RecipeBook.draftedRecipe
            RecipeBook.allRecipes.append(finalRecipe)
        }
        self.navigationController?.popToRootViewController(animated: true)
        }
        else {
            Utilities.showAlertMessage(vc: self, title: "Error", message: "Please take an image!")
        }
    }
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
        imagePicker.sourceType = .camera
        self.navigationController?.present(imagePicker, animated: true, completion: {
        })
    }
    @IBAction func libraryButtonPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        self.navigationController?.present(imagePicker, animated: true, completion: {
        })
    }
    
}

extension EditPictureController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            takenImage = image
            self.recipeImage.image = image
            self.recipeImage.contentMode = .scaleAspectFill
            photoTaken = true
        }
    }
    
}
