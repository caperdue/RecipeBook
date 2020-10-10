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
    func sendSteps()
}


class listCell: UITableViewCell {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var numberLabel: UILabel!
   
    @IBOutlet weak var editImage: UIImageView!
    
    @IBOutlet weak var editButton: UIButton!
   
    //Change this method. Refer to this: https://stackoverflow.com/questions/31222275/swift-delegate-beetween-two-view-controller-without-segue
    
    let stepsVC = StepsController()
    
    
    
    @IBAction func editButtonPressed(_ sender: Any) {
        toggleCellEditing()

    }
    
    //Need this to be registered in StepsController

    override func awakeFromNib() {
        stepsVC.delegate = self
        super.awakeFromNib()
        textView.delegate = self
        textView.isScrollEnabled = false
        
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 5)
        
        textView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        
        textView.textColor = UIColor.lightGray
        textView.text = "Enter first step here"
        
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
extension listCell: StepsControllerVC {
    func toggleCellEditing() {
        if textView.isUserInteractionEnabled {
            textView.isUserInteractionEnabled = false
            editImage.image = UIImage(systemName: "pencil.circle")
        }
        else {
            textView.isUserInteractionEnabled = true
            editImage.image = UIImage(systemName: "pencil.circle.fill")
        }
    }
    
    
}

extension listCell: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
            
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter first step here"
            textView.textColor = UIColor.lightGray
        }
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
    

