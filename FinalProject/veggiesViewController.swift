//
//  veggiesViewController.swift
//  FinalProject
//
//  Created by Justin Bohrer on 12/7/24.
//

import UIKit

class veggiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var cells: UITableView!
    
    let vegetables = ["Lettuce", "Tomato", "Pico", "Cabbage", "Corn", "Grilled Onions", "Guacamole"]
    
    weak var delegate: veggiesSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cells.delegate = self
        cells.dataSource = self
        
        let darkMode = UserDefaults.standard.bool(forKey: "Dark/Light_Mode")
        if darkMode {
            self.view.backgroundColor = .darkGray
            self.cells.backgroundColor = .darkGray
        } else {
            self.view.backgroundColor = .lightGray
            self.cells.backgroundColor = .lightGray
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vegetables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedVeggies = delegate?.selectedVegetables()
        let cell = tableView.dequeueReusableCell(withIdentifier: "vegetableCell", for: indexPath)
        let veggie = vegetables[indexPath.row]
                
        cell.textLabel?.numberOfLines = 0
            
        if (selectedVeggies?.contains(veggie) == true) {
            cell.textLabel?.text = "\(veggie)  X"
        } else {
            cell.textLabel?.text = "\(veggie)"
        }
            

        let darkMode = UserDefaults.standard.bool(forKey: "Dark/Light_Mode")
        
        if (darkMode) {
            cell.backgroundColor = .darkGray
        }
        else{
            cell.backgroundColor = .lightGray
        }
                
            return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVeggie = vegetables[indexPath.row]
        delegate?.didSelectVegetable(selectedVeggie)
        self.dismiss(animated: true)
    }
    
}
