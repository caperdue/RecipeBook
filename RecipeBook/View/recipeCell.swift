//
//  recipeCell.swift
//  RecipeBook
//
//  Created by Carly Perdue on 12/20/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import UIKit

class recipeCell: UICollectionViewCell {

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var editLabel: UILabel!
    
    @IBAction func favoritesTapped(_ sender: UIButton) {
        favoritesButton.isSelected = !favoritesButton.isSelected
        if recipeNameLabel.text != "" {
            for i in RecipeBook.allRecipes {
                if i.getRecipeName() == recipeNameLabel.text {
                    i.setFavorite(favoritesButton.isSelected)
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10
        imageLabel.layer.cornerRadius = 10
    }
}


