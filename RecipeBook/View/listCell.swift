//
//  listCell.swift
//  RecipeBook
//
//  Created by Carly Perdue on 10/7/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit




class listCell: UITableViewCell {
    
    var delegate: UITextViewDelegate?
    @IBOutlet weak var textEntry: UITextView!
    //Need this to be registered in StepsController
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate?.textViewDidChange?(textEntry)
    }
    
}
