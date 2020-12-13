//
//  StepsController.swift
//  RecipeBook
//
//  Created by Carly Perdue on 10/5/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit

//Fix to add so that cell is notified when the add button is pressed to dismiss editing.
protocol StepsControllerVCDelegate {
    func userPressedAdd()
    func changeStep(step: Int)
    func getStepText() -> String
}

class StepsController: UIViewController, UITextFieldDelegate {
    var delegate: StepsControllerVCDelegate?
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var steps:[String] = []
    var numSteps:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.layer.cornerRadius = 17
        stepsLabel.layer.cornerRadius = 10
        topView.layer.cornerRadius = 10
        tableView.register(UINib(nibName: "listCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        tableView.contentInset = UIEdgeInsets(top: 50,left: 0,bottom: 0,right: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        tableView.backgroundColor = tableView.backgroundColor!.withAlphaComponent(0.5)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func addStepButton(_ sender: UIButton) {
        if delegate?.getStepText() != "" && delegate?.getStepText() != "Enter step here" {
            numSteps += 1
            tableView.reloadData()
           // tableView.scroll(to: .bottom, animated: true)
        }
        
        print(steps)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
               tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + tableView.rowHeight, right: 0)
           }
       }

       @objc private func keyboardWillHide(notification: NSNotification) {
           tableView.contentInset = .zero
       }
    }


extension UITableView {
    public func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion:{ _ in
            completion()
        })
    }
   
    //Custom scroll function to adhere to the dynamic height
    func scroll(to: scrollsTo, animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            switch to {
            case .top:
                if numberOfRows > 0 {
                     let indexPath = IndexPath(row: 0, section: 0)
                     self.scrollToRow(at: indexPath, at: .top, animated: animated)
                }
                break
            case .bottom:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
                break
            }
        }
    }

    enum scrollsTo {
        case top,bottom
    }
}

extension StepsController: UITableViewDataSource, UITableViewDelegate {
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numSteps
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! listCell
        self.delegate = cell
        cell.delegate = self
        
        cell.setNeedsUpdateConstraints()
            cell.updateConstraintsIfNeeded()
        
        cell.backgroundColor = UIColor.clear
        
      if numSteps > 1 {
        delegate?.changeStep(step: indexPath.row+1)
            
      }
        
        return cell
            
    }
}

extension StepsController: listCellDelegate {
    func getPlaceHolderText() -> String {
        return Utilities.stepsPlaceHolder
    }
    
    
}










