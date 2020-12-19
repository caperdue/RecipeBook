//
//  ingredientCell.swift
//  RecipeBook
//
//  Created by Carly Perdue on 10/12/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit


class ingredientCell: UITableViewCell {

    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var content: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        content.layer.cornerRadius = 10


    }
}
