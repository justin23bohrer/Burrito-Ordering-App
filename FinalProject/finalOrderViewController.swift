//
//  finalOrderViewController.swift
//  FinalProject
//
//  Created by Justin Bohrer on 12/8/24.
//

import UIKit

class finalOrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var finalOrder: UITableView!
    @IBOutlet weak var tot: UILabel!
    @IBOutlet weak var loc: UILabel!
    
    
    var finalOrderData: [Food] = []
    var storeName: String = ""
    var finalTot: Int = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        finalOrder.dataSource = self
        finalOrder.delegate = self
        finalOrder.reloadData()
        let total = Double(finalOrderData.count) * 7.59
        print(total)
        tot.text = String(format: "Your Order: $%.2f", total)
        loc.text = "Order Sent To: \(storeName)"
        let darkMode = UserDefaults.standard.bool(forKey: "Dark/Light_Mode")
        if darkMode {
            self.view.backgroundColor = .darkGray
        } else {
            self.view.backgroundColor = .lightGray
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalOrderData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath)
        let food = finalOrderData[indexPath.row]
        
        var orderSummary = "\(food.choice) with"
                
        if !food.bread.isEmpty {
            orderSummary += " \(food.bread)"
        }
        if !food.rice.isEmpty {
            orderSummary += ", \(food.rice)"
        }
        if !food.beans.isEmpty {
            orderSummary += ", \(food.beans)"
        }
        if !food.meat.isEmpty {
            orderSummary += ", \(food.meat)"
        }
        if !food.vegetables.isEmpty {
            orderSummary += ", \(food.vegetables.joined(separator: ", "))"
        }
        if !food.sauces.isEmpty {
            orderSummary += ", \(food.sauces) Sauce"
        }
                
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = orderSummary
        
        let darkMode = UserDefaults.standard.bool(forKey: "Dark/Light_Mode")
        
        if (darkMode) {
            cell.backgroundColor = .lightGray
            finalOrder.backgroundColor = .lightGray
        }
        else{
            cell.backgroundColor = .darkGray
            finalOrder.backgroundColor = .lightGray
        }
                
        return cell
    }
        
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
