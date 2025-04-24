//
//  FullOrderViewController.swift
//  FinalProject
//
//  Created by Justin Bohrer on 12/3/24.
//
class Food {
    var choice: String
    var bread: String
    var beans: String
    var rice: String
    var meat: String
    var vegetables: [String]
    var sauces: String
    
    init(choice: String, bread: String, beans: String, rice: String, meat: String, vegetables: [String], sauces: String) {
        self.choice = choice
        self.bread = bread
        self.beans = beans
        self.meat = meat
        self.rice = rice
        self.vegetables = vegetables
        self.sauces = sauces
    }
}
import UIKit

class FullOrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var order: Food?
    
    var restaurantName: String = ""
    
    var fullOrder: [Food] = []
    
    let textCellid = "textCell"
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.setNavigationBarHidden(true, animated: true)
        let darkMode = UserDefaults.standard.bool(forKey: "Dark/Light_Mode")
        if darkMode {
            self.view.backgroundColor = .darkGray
            self.bottomView.backgroundColor = .darkGray
            self.tableView.backgroundColor = .darkGray
        } else {
            self.view.backgroundColor = .lightGray
            self.bottomView.backgroundColor = .lightGray
            self.tableView.backgroundColor = .lightGray
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fullOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath)
        let food = fullOrder[indexPath.row]
        
        let darkMode = UserDefaults.standard.bool(forKey: "Dark/Light_Mode")
        
        if (darkMode) {
            cell.backgroundColor = .darkGray
        }
        else{
            cell.backgroundColor = .lightGray
        }
        
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
        cell.backgroundColor = .lightGray
                
        return cell
    }
    
    func addFood(_ food: Food) {
        fullOrder.append(food)
        tableView.reloadData()
    }
    
    
    @IBAction func finalOrder(_ sender: Any) {
        
        let alert = UIAlertController(
                    title: "Are you confirming this order?",
                    message: "No changes can be made after this.",
                    preferredStyle: .alert)
                
        alert.addAction(UIAlertAction(title: "Correct", style: .default, handler: { _ in
            self.performSegue(withIdentifier: "goToFinal", sender: self)
        }))
                
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in
        }))
                
        present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            fullOrder.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFinal" {
            if let destinationVC = segue.destination as? finalOrderViewController {
                destinationVC.finalOrderData = fullOrder
                destinationVC.storeName = restaurantName
                navigationController?.popViewController(animated: false)
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fullOrder = [] 
    }
    
}
