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
    func tellDoneEditing(cell: UITableViewCell, _ step: String)
}


class listCell: UITableViewCell {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var editImage: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    
    var delegate: listCellDelegate?
    
    @IBOutlet weak var content: UIView!
    
    //Need this to be registered in StepsController
    override func awakeFromNib() {
        
        super.awakeFromNib()
        textView.delegate = self
        textView.isScrollEnabled = false
        
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 5)
        
        textView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        
        textView.textColor = UIColor.lightGray
        textView.text = "Enter first step here"
        
        content.layer.cornerRadius = 17

    }
    

    //Get current value of the textView
    var textString: String {
        get {
            return textView.text
        }
        set {
            textView.text = newValue
            textViewDidChange(textView)
        }
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
            textView.text = "Enter first step here"
            textView.textColor = UIColor.lightGray
            
        }
        editImage.image = UIImage(systemName: "pencil.circle")
        
        //Tell the StepsController that the cell is no longer being edited
        delegate?.tellDoneEditing(cell: self, textView.text)
    }
    func textViewDidChange(_ textView: UITextView) {
       
        let size = textView.bounds.size
        let newSize = textView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
           
        // Resize the cell only when cell's size is changed
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            tableView?.beginUpdates()
            tableView?.endUpdates()
            UIView.setAnimationsEnabled(true)
               
        if let thisIndexPath = tableView?.indexPath(for: self) {
            tableView?.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
               }
           }
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
    
    
    //Tell the StepsController that the add button was pressed when currently was not done editing (user didn't click off screen first)
    func userPressedAdd() {
        //If keyboard still present
        self.endEditing(true)
        if textView.text != "Enter first step here" && textView.text != "" {
            delegate?.tellDoneEditing(cell: self, textView.text)
        }
            
        }
    }

    

