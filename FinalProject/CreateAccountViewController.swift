//
//  CreateAccountViewController.swift
//  FinalProject
//
//  Created by Justin Bohrer on 12/3/24.
//

import UIKit
import Photos
import FirebaseAuth
import AVFoundation
import FirebaseStorage

class CreateAccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var conPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var proPic: UIImageView!
    
    @IBOutlet weak var photoButton: UIButton!
    
    var userCircularImage: UIImage? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        proPic.image = UIImage(named: "base.png")
        status.text = ""
        let width = proPic.layer.frame.width
        let height = proPic.layer.frame.height
        let radius = width / 2.0
        proPic.layer.cornerRadius = radius;
        proPic.layer.masksToBounds = true;
        
        let darkMode = UserDefaults.standard.bool(forKey: "Dark/Light_Mode")
        if darkMode {
            self.view.backgroundColor = .darkGray
        } else {
            self.view.backgroundColor = .lightGray
        }
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Choose Photo", message: "Select a photo source", preferredStyle: .actionSheet)
                
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                alertController.addAction(UIAlertAction(title: "Take a Photo", style: .default, handler: { _ in
                self.requestCameraPermission()
                }))
        }

        alertController.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            self.requestPhotoLibraryPermission()
        }))
                
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
        self.present(alertController, animated: true, completion: nil)
    }
            
    func requestCameraPermission() {
            AVCaptureDevice.requestAccess(for: .video) { response in
                DispatchQueue.main.async {
                    if response {
                        self.presentImagePicker(sourceType: .camera)
                    } else {
                        self.showPermissionDeniedAlert(permission: "camera")
                    }
                }
            }
        }

        func requestPhotoLibraryPermission() {
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        self.presentImagePicker(sourceType: .photoLibrary)
                    case .denied, .restricted:
                        self.showPermissionDeniedAlert(permission: "photo library")
                    case .notDetermined:
                        PHPhotoLibrary.requestAuthorization { newStatus in
                            if newStatus == .authorized {
                                self.presentImagePicker(sourceType: .photoLibrary)
                            } else {
                                self.showPermissionDeniedAlert(permission: "photo library")
                            }
                        }
                    default:
                        break
                    }
                }
            }
        }
                
        func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }

        func showPermissionDeniedAlert(permission: String) {
            let alert = UIAlertController(title: "Permission Denied", message: "Please grant permission to access your \(permission) in Settings.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                    
                if let circularImage = cropImageToSquare(image: selectedImage) {
                    proPic.image = circularImage
                    userCircularImage = circularImage
                }
            }
            picker.dismiss(animated: true, completion: nil)
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

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }

        func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
            let size = image.size
            let widthRatio  = targetSize.width  / size.width
            let heightRatio = targetSize.height / size.height
                
            let scaleFactor = min(widthRatio, heightRatio)
                
            let newSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
                
            UIGraphicsBeginImageContextWithOptions(newSize, false, image.scale)
            image.draw(in: CGRect(origin: .zero, size: newSize))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
                
            return resizedImage ?? image
        }

        func cropImageToSquare(image: UIImage) -> UIImage? {
            var imageHeight = image.size.height
            var imageWidth = image.size.width

            if imageHeight > imageWidth {
                imageHeight = imageWidth
            }
            else {
                imageWidth = imageHeight
            }

            let size = CGSize(width: imageWidth, height: imageHeight)

            if let cgImage = image.cgImage {
                let refWidth : CGFloat = CGFloat(cgImage.width)
                let refHeight : CGFloat = CGFloat(cgImage.height)

                let x = (refWidth - size.width) / 2
                let y = (refHeight - size.height) / 2

                let cropRect = CGRectMake(x, y, size.height, size.width)
                if let imageRef = cgImage.cropping(to: cropRect) {
                    return UIImage(cgImage: imageRef, scale: 0, orientation: image.imageOrientation)
                }
            }

           return nil
        }

        
    @IBAction func createAccount(_ sender: Any) {

        let emailField = email.text!
        let passwordField = password.text!
        
        if conPassword.text! != password.text!{
            status.text = "Incorrect Passwords"
            return
        }
        
        Auth.auth().createUser(withEmail: emailField, password: passwordField) { (authResult, error) in
            if let error = error {
                self.status.text = "Unsuccessful Sign up"
            } else {
                self.status.text = "Account created successfully"
                if let image = self.userCircularImage {
                    self.uploadProfileImage(image)
                }
                self.dismiss(animated: true)
                
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
