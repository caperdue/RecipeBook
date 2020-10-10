//
//  StepsController.swift
//  RecipeBook
//
//  Created by Carly Perdue on 10/5/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation
import UIKit

protocol StepsControllerVC {
    func toggleCellEditing()
}

class StepsController: UIViewController, UITextFieldDelegate {

    var steps:[String] = ["`"]
    var delegate: StepsControllerVC?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 22
        tableView.rowHeight = UITableView.automaticDimension
        
        
        tableView.register(UINib(nibName: "listCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        delegate?.toggleCellEditing()
    }
    
    
    @IBAction func addStepButton(_ sender: UIButton) {
        
    }
    
}

extension StepsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! listCell
        //listCell refers to nibName
        return cell
    }
    
    
}







