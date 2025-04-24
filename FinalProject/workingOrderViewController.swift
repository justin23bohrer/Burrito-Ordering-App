//
//  workingOrderViewController.swift
//  FinalProject
//
//  Created by Justin Bohrer on 12/3/24.
//
protocol veggiesSelectionDelegate: AnyObject {
    func didSelectVegetable(_ vegetable: String)
    func selectedVegetables() -> [String]
}

import UIKit

class workingOrderViewController: UIViewController, veggiesSelectionDelegate{
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var fullOrderLabel: UILabel!
    
    @IBOutlet weak var meat: UIView!
    @IBOutlet weak var breadView: UIView!
    
    
    var delegate: FullOrderViewController!
    var currentFood: Food?
    var selectedVegetable: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateFullOrderLabel()
        self.mainLabel.text = "Let's design your \(self.currentFood?.choice ?? "dish")!"
        navigationController?.setNavigationBarHidden(true, animated: true)
        if self.currentFood?.choice == "Bowl" || self.currentFood?.choice == "Nachos"{
            breadView.isHidden = true
        }
        else{
            breadView.isHidden = false
        }
        let darkMode = UserDefaults.standard.bool(forKey: "Dark/Light_Mode")
        if darkMode {
            self.view.backgroundColor = .darkGray
        } else {
            self.view.backgroundColor = .lightGray
        }
        
        let v = UserDefaults.standard.bool(forKey: "nonvegan")
        if v {
            meat.isHidden = false
        } else {
            meat.isHidden = true
        }
    }
    
    @IBAction func breadButton(_ sender: Any) {
        let alert = UIAlertController(title: "Select Bread", message: "Choose a bread type", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "flour", style: .default, handler: { _ in
            self.currentFood?.bread = "flour"
            self.updateFullOrderLabel()
        }))
        alert.addAction(UIAlertAction(title: "corn", style: .default, handler: { _ in
            self.currentFood?.bread = "corn"
            self.updateFullOrderLabel()
        }))
        present(alert, animated: true)
    }
    
    @IBAction func riceButton(_ sender: Any) {
        let alert = UIAlertController(title: "Select Rice", message: "Choose a rice type", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "White Rice", style: .default, handler: { _ in
            self.currentFood?.rice = "White Rice"
            self.updateFullOrderLabel()
        }))
        alert.addAction(UIAlertAction(title: "Brown Rice", style: .default, handler: { _ in
            self.currentFood?.rice = "Brown Rice"
            self.updateFullOrderLabel()
        }))
        present(alert, animated: true)
    }
    
    @IBAction func beansButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Select Beans", message: "Choose a beans type", preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Black Beans", style: .default, handler: { _ in
            self.currentFood?.beans = "Black Beans"
            self.updateFullOrderLabel()
        }))

        actionSheet.addAction(UIAlertAction(title: "Pinto Beans", style: .default, handler: { _ in
            self.currentFood?.beans = "Pinto Beans"
            self.updateFullOrderLabel()
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 1, height: 1)  
        }

        present(actionSheet, animated: true)
    }
    
    @IBAction func meatButton(_ sender: Any) {
        let alert = UIAlertController(title: "Select Meat", message: "Choose a meat type", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Chicken", style: .default, handler: { _ in
            self.currentFood?.meat = "Chicken"
            self.updateFullOrderLabel()
        }))
        alert.addAction(UIAlertAction(title: "Beef", style: .default, handler: { _ in
            self.currentFood?.meat = "Beef"
            self.updateFullOrderLabel()
        }))
        present(alert, animated: true)
    }
    
    @IBAction func vegetablesButton(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVeggies" {
            if let veggiesVC = segue.destination as? veggiesViewController {
                veggiesVC.delegate = self
            }
        }
    }
    
    func selectedVegetables() -> [String] {
        self.currentFood?.vegetables ?? []
    }
    
    func didSelectVegetable(_ vegetable: String) {
        self.currentFood?.vegetables.append(vegetable)
        self.updateFullOrderLabel()
    }
    
    @IBAction func saucesbutton(_ sender: Any) {
        let alert = UIAlertController(title: "Select Sauces", message: "Choose a sauce type", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Mild", style: .default, handler: { _ in
            self.currentFood?.sauces = "Mild"
            self.updateFullOrderLabel()
        }))
        alert.addAction(UIAlertAction(title: "Hot", style: .default, handler: { _ in
            self.currentFood?.sauces = "Hot"
            self.updateFullOrderLabel()
        }))
        present(alert, animated: true)
    }
    
    func updateFullOrderLabel() {
        var orderSummary = "Order Summary: "
        
        if let choice = self.currentFood?.choice {
            orderSummary += "One \(choice) with"
        } else {
            orderSummary += "One dish with"
        }
        
        if let bread = self.currentFood?.bread, !bread.isEmpty {
            orderSummary += " \(bread)"
        }
        if let rice = self.currentFood?.rice, !rice.isEmpty {
            orderSummary += " \(rice)"
        }
        if let beans = self.currentFood?.beans, !beans.isEmpty {
            orderSummary += " \(beans)"
        }
        if let meat = self.currentFood?.meat, !meat.isEmpty {
            orderSummary += " \(meat)"
        }
        if let vegetables = self.currentFood?.vegetables, !vegetables.isEmpty {
            orderSummary += " \(vegetables.joined(separator: ", "))"
        }
        if let sauces = self.currentFood?.sauces, !sauces.isEmpty {
            orderSummary += " \(sauces) Sauce"
        }
        
        self.fullOrderLabel.text = orderSummary
    }
        
        
    @IBAction func goHome(_ sender: Any) {
        if let currentFood = currentFood {
            self.delegate?.addFood(currentFood)
            self.dismiss(animated: true, completion: nil)
        }
    }
        
}
