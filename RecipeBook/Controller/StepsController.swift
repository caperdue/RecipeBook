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

    var steps:[String] = []
    var numSteps:Int = 1
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 22
        tableView.rowHeight = UITableView.automaticDimension
        tableView.layer.cornerRadius = 17
        
        tableView.register(UINib(nibName: "listCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func addStepButton(_ sender: UIButton) {
        if delegate?.getStepText() != "" {
            numSteps += 1
            tableView.reloadData()
            tableView.scroll(to: .bottom, animated: true)
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
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))

            let label = UILabel()
            label.frame = CGRect.init(x: 20, y: -10, width: headerView.frame.width-10, height: headerView.frame.height-10)
        
        
        switch(section){
            case 0:
                label.font = UIFont.boldSystemFont(ofSize: 20)
                label.text = "Steps"
        
            case 1:
                label.text = "Notes"
                label.font = UIFont.boldSystemFont(ofSize: 15)
            
            default:
                label.text = ""
        }
        
            headerView.addSubview(label)

            return headerView
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numSteps
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! listCell
        cell.editImage.isHidden = false
        self.delegate = cell
        cell.delegate = self
        
        
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










