//
//  ViewController.swift
//  RecipeBook
//
//  Created by Carly Perdue on 9/12/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import UIKit
import Foundation

class RecipeController: UIViewController {
    @IBOutlet weak var recipeCollectionView: UICollectionView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var tappedRecipe = Recipe()
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            //Take the drafted recipe object and reset it every time the will view load here
            Utilities.resetDraft()
            self.recipeCollectionView.reloadData()
        }
        deleteButton.isEnabled = false
        deleteButton.image = .none
        deleteButton.title = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeCollectionView.delegate = self
        recipeCollectionView.dataSource = self
        var test = Recipe()
        test.setTime(["hr(s)": 3, "min(s)": 2])
        do {
        let testI = try Ingredient(name: "poop", amount: ["whole": 0, "numerator": 1, "denominator": 2], measurementType: "cups", liquidOrSolid: "solid")
            test.addIngredient(testI)
            RecipeBook.allRecipes.append(test)
        }
        catch{
            print(Error.self)
        }
        
    

        //Registering the nib to link to the CollectionView
        recipeCollectionView.register(UINib(nibName: "recipeCell", bundle: nil), forCellWithReuseIdentifier: "ReusableRecipeCell")
   
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 5
            layout.sectionInset.right = 0
            recipeCollectionView.setCollectionViewLayout(layout, animated: true)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewRecipeSegue" {
            let destinationVC = segue.destination as! ViewRecipeController
             destinationVC.delegate = self
        }
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        if let selectedCells = recipeCollectionView.indexPathsForSelectedItems {
            for i in 0..<selectedCells.count {
                RecipeBook.allRecipes.remove(at: i)
            }
            recipeCollectionView.deleteItems(at: selectedCells)
        }
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if #available(iOS 14.0, *) {
            recipeCollectionView.isEditing = !recipeCollectionView.isEditing
            if recipeCollectionView.isEditing {
               editButton.title = "Done"
               deleteButton.isEnabled = true
                deleteButton.image = UIImage(systemName: "trash")
                deleteButton.title = ""
                addButton.isEnabled = false
                
            }
            else {
                editButton.title = "Edit"
                deleteButton.isEnabled = false
                deleteButton.image = .none
                deleteButton.title = ""
                addButton.isEnabled = true
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
}
    
extension RecipeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.indexPathsForVisibleItems.contains(indexPath) {
            if #available(iOS 14.0, *) {
                if recipeCollectionView.isEditing {
                    guard let deselectedCell = collectionView.cellForItem(at: indexPath) as? recipeCell else { fatalError("Couldn't return a photo cell") }
                    deselectedCell.editLabel.isHidden = !deselectedCell.editLabel.isHidden
                }
                else {
                    performSegue(withIdentifier: "viewRecipeSegue", sender: self)
                    tappedRecipe = RecipeBook.allRecipes[indexPath.row]
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowLayout?.minimumInteritemSpacing ?? 0.0) + (flowLayout?.sectionInset.left ?? 0.0) + (flowLayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (recipeCollectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size*1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RecipeBook.allRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = recipeCollectionView.dequeueReusableCell(withReuseIdentifier: "ReusableRecipeCell", for: indexPath) as! recipeCell
        cell.timeLabel?.text = RecipeBook.allRecipes[indexPath.row].parseTime()
        cell.recipeNameLabel?.text = RecipeBook.allRecipes[indexPath.row].getRecipeName()
        
        if let validImage = RecipeBook.allRecipes[indexPath.row].getImage(){
            cell.imageLabel?.alpha = 1
            cell.imageLabel?.image = validImage
        }
        else {
            cell.imageLabel?.image = UIImage(systemName: "xmark.rectangle")
        }
        cell.imageLabel?.contentMode = .scaleAspectFill
        cell.favoritesButton?.isSelected = RecipeBook.allRecipes[indexPath.row].getFavorite() ?? false
        return cell

    }
}
extension RecipeController: RecipeViewDelegate {
    func retrieveRecipe() -> Recipe {
        return tappedRecipe
    }
}
