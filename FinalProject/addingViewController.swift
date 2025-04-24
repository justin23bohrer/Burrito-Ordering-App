//
//  addingViewController.swift
//  FinalProject
//
//  Created by Justin Bohrer on 12/3/24.
//

import UIKit

protocol workingOrderViewControllerDelegate: AnyObject {
    func addFood(_ food: Food)
}

class addingViewController: UIViewController, workingOrderViewControllerDelegate {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    var selectedChoice: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let darkMode = UserDefaults.standard.bool(forKey: "Dark/Light_Mode")
        if darkMode {
            self.view.backgroundColor = .darkGray
            self.view1.backgroundColor = .darkGray
            self.view2.backgroundColor = .darkGray
            self.view3.backgroundColor = .darkGray
            self.view4.backgroundColor = .darkGray
        } else {
            self.view.backgroundColor = .lightGray
            self.view1.backgroundColor = .lightGray
            self.view2.backgroundColor = .lightGray
            self.view3.backgroundColor = .lightGray
            self.view4.backgroundColor = .lightGray
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    
    @IBAction func burrito(_ sender: Any) {
        selectedChoice = "Burrito"
        performSegue(withIdentifier: "makeFood", sender: self)
    }
    
    @IBAction func tacos(_ sender: Any) {
        selectedChoice = "Tacos"
        performSegue(withIdentifier: "makeFood", sender: self)
    }
    
    @IBAction func nachos(_ sender: Any) {
        selectedChoice = "Nachos"
        performSegue(withIdentifier: "makeFood", sender: self)
    }
    
    @IBAction func bowl(_ sender: Any) {
        selectedChoice = "Bowl"
        performSegue(withIdentifier: "makeFood", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "makeFood" {
            if let workingOrderVC = segue.destination as? workingOrderViewController {
                workingOrderVC.currentFood = Food(choice: selectedChoice ?? "Unknown", bread: "", beans: "", rice: "", meat: "", vegetables: [], sauces: "")
                if let fullOrderVC = navigationController?.viewControllers.first(where: { $0 is FullOrderViewController }) as? FullOrderViewController {
                    workingOrderVC.delegate = fullOrderVC
                } else {
                    print("FullOrderViewController not found!")
                }
                navigationController?.popViewController(animated: false)
            }
        }
    }
    
    func addFood(_ food: Food) {
        if let fullOrderVC = navigationController?.viewControllers.first(where: { $0 is FullOrderViewController }) as? FullOrderViewController {
            fullOrderVC.addFood(food)
        } else {
            print("FullOrderViewController not found!")
        }
    }
    
}
