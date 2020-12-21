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
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.recipeCollectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeCollectionView.delegate = self
        recipeCollectionView.dataSource = self
       
        //Registering the nib to link to the CollectionView
        recipeCollectionView.register(UINib(nibName: "recipeCell", bundle: nil), forCellWithReuseIdentifier: "ReusableRecipeCell")
   
        
        let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .vertical
                layout.minimumLineSpacing = 15
                layout.minimumInteritemSpacing = 15
        
                recipeCollectionView.setCollectionViewLayout(layout, animated: true)

        var recipe:Recipe = Recipe()
        recipe.setName("Lasagnja")
        recipe.setTime("1 hr, 30 min")
        for i in 1...20 {
        RecipeBook.allRecipes.append(recipe)
        }
    }
    
       
    
}

extension RecipeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        cell.timeLabel?.text = RecipeBook.allRecipes[indexPath.row].getTime()
        cell.recipeNameLabel?.text = RecipeBook.allRecipes[indexPath.row].getRecipeName()
        

        
        return cell

    }
    

        

}


