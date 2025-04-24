//
//  settingViewController.swift
//  FinalProject
//
//  Created by Justin Bohrer on 12/3/24.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class settingViewController: UIViewController {

    @IBOutlet weak var lightnDark: UISegmentedControl!
    
    @IBOutlet weak var vegan: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        navigationController?.setNavigationBarHidden(false, animated: false)
        let darkMode = UserDefaults.standard.bool(forKey: "Dark/Light_Mode")
        if darkMode {
            self.view.backgroundColor = .darkGray
        } else {
            self.view.backgroundColor = .lightGray
        }
    }
    
    @IBAction func lightAndDarkChanger(_ sender: Any) {
        let selectedSegmentIndex = lightnDark.selectedSegmentIndex
        switch selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set(false, forKey: "Dark/Light_Mode")
            self.view.backgroundColor = .lightGray
        case 1:
            UserDefaults.standard.set(true, forKey: "Dark/Light_Mode")
            self.view.backgroundColor = .darkGray
        default:
            break
        }
        
    }
    
    
    @IBAction func deleteAcc(_ sender: Any) {
        
        guard let user = Auth.auth().currentUser else {
            print("No user is currently signed in.")
            return
        }
        
        guard let email = user.email else {
            print("User email is unavailable.")
            return
        }
                
        let alertController = UIAlertController(title: "Delete Account", message: "Type in password", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            textField.placeholder = "Password"
        }
        


        var password = ""
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Delete", style: .default) { _ in
            password = alertController.textFields![0].text ?? ""
            print(password)
            print("hit me\n\n\n\n\n\n")
            let credential = EmailAuthProvider.credential(withEmail: email, password: password)
            user.reauthenticate(with: credential) { (result, error) in
                if let error = error {
                    print("Reauthentication failed: \(error.localizedDescription)")
                } else {
                    user.delete { error in
                        if let error = error {
                            print("Error deleting user: \(error.localizedDescription)")
                        } else {
                            do {
                                try Auth.auth().signOut()
                                self.dismiss(animated: true, completion: nil)
                            } catch let logoutError {
                                print("Logout failed: \(logoutError.localizedDescription)")
                            }
                        }
                    }
                }
            }

        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
        
        performSegue(withIdentifier: "home", sender: self)
    }
    
    func uploadProfileImage(_ image: UIImage) {
        let imageName = Auth.auth().currentUser?.uid ?? "myimage"
        let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")
        print("Image name is \(imageName).jpg")

        if let uploadData = image.jpegData(compressionQuality: 0.1) {
            storageRef.putData(uploadData, metadata: nil, completion: { (_, error) in
                if let error = error {
                    print(error)
                    return
                } else {
                    print("Uploaded user profile")
                }
            })
        }
    }
    
    
    
    
    @IBAction func veganOrNah(_ sender: Any) {
        let selectedSegmentIndex = vegan.selectedSegmentIndex
        switch selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set(true, forKey: "nonvegan")
        case 1:
            UserDefaults.standard.set(false, forKey: "nonvegan")
        default:
            break
        }
    }
    
    
}
