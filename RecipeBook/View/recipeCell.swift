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
    
    @IBOutlet weak var favoritesLabel: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10
    }

}
