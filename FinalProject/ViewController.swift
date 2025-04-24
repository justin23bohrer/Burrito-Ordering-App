//
//  ViewController.swift
//  FinalProject
//
//  Created by Justin Bohrer on 12/3/24.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        status.text = ""
        let darkMode = UserDefaults.standard.bool(forKey: "Dark/Light_Mode")
        if darkMode {
            self.view.backgroundColor = .darkGray
        } else {
            self.view.backgroundColor = .lightGray
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        navigationController?.setNavigationBarHidden(true, animated: false)
    }


    @IBAction func loginPushed(_ sender: Any) {
        let emailField = username.text!
        let passwordField = password.text!
        Auth.auth().signIn(withEmail: emailField, password: passwordField){
            (authResult,error) in
            if let error = error as NSError? {
                self.status.text = "Unsuccessful Login"
            }
            else{
                self.status.text = "Logged in!"
                self.performSegue(withIdentifier: "gotIn", sender: self)
            }
        }
    }
    // Called when 'return' key pressed
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user clicks on the view outside of the UITextField
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

