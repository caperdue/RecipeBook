//
//  StepsController.swift
//  RecipeBook
//
//  Created by Carly Perdue on 10/5/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit

class StepsController: UIViewController {
    
    var steps:[String] = ["hello"]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "listCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        let VC = listCell()
        VC.delegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension StepsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! listCell
        //listCell refers to nibName
        
        let text = ""
        cell.textLabel?.text = text
        return cell
    }
    
    
}
//FIX ME
extension StepsController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print("ran")
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}





