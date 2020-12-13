//
//  listCell.swift
//  RecipeBook
//
//  Created by Carly Perdue on 10/7/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit

protocol listCellDelegate {
    func getPlaceHolderText() -> String
}

class listCell: UITableViewCell {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var editImage: UIImageView!
    //@IBOutlet weak var editButton: UIButton!
    
   // @IBOutlet weak var content: UIView!
    
    var delegate: listCellDelegate?
    //Need this to be registered in StepsController
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self

        textView.isScrollEnabled = false
        
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 5)
        
        textView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        
        textView.textColor = UIColor.lightGray
        textView.text = "Enter first step here"
        
       // content.layer.cornerRadius = 10

    }

}

extension listCell: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        //If nothing is entered in box, then change symbol and remove placeholder text
        if textView.textColor == UIColor.lightGray  {
            textView.text = ""
            textView.textColor = UIColor.black
            editImage.image = UIImage(systemName: "pencil.circle.fill")
            
        }
        
        //If something is entered in box, then just change the image
        if textView.textColor == UIColor.black {
            editImage.image = UIImage(systemName: "pencil.circle.fill")
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = delegate?.getPlaceHolderText()
            textView.textColor = UIColor.lightGray
            
        }
        editImage.image = UIImage(systemName: "pencil.circle")
    }
    func textViewDidChange(_ textView: UITextView) {
        UIView.setAnimationsEnabled(false)
        tableView?.beginUpdates()
        tableView?.endUpdates()
        UIView.setAnimationsEnabled(true)
        

       }
        
}

//Look up view hierarchy to see the containing table view
extension UITableViewCell {
    var tableView: UITableView? {
            get {
                var table: UIView? = superview
                while !(table is UITableView) && table != nil {
                    table = table?.superview
                }

                return table as? UITableView
            }
        }
}


extension listCell: StepsControllerVCDelegate {

    func getStepText() -> String {
        return textView.text
    }
    func changeStep(step: Int) {
        numberLabel.text = "\(step)."
    }

    func userPressedAdd() {
        //If keyboard still present, end editing
        self.endEditing(true)
        }
    }

    

