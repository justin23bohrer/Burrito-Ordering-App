//
//  findStoreViewController.swift
//  FinalProject
//
//  Created by Justin Bohrer on 12/3/24.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseStorage

class findStoreViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var proPic: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    var restaurantName2: String = ""
    
    let restaurantLocations = [
        (name: "Cabo Bob's 1", latitude: 30.2957, longitude: -97.7442),
        (name: "Cabo Bob's 2", latitude: 30.2334, longitude: -97.8243),
        (name: "Cabo Bob's 3", latitude: 30.2210, longitude: -97.7570)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageName = Auth.auth().currentUser?.uid ?? "myimage"
        let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")

        print("Image name is \(imageName).jpg")
        storageRef.downloadURL { (URL, error) in
            if (URL != nil && error == nil) {
                let data = NSData(contentsOf: URL!)
                let image = UIImage(data: data! as Data)
                self.proPic.image = image
            } else {
                print("Error is \(error?.localizedDescription)")
            }
        }


        let width = proPic.layer.frame.width
        let height = proPic.layer.frame.height
        let radius = width / 2.0
        proPic.layer.cornerRadius = radius;
        proPic.clipsToBounds = true;

        
        mapView.layer.cornerRadius = 50
        mapView.layer.masksToBounds = true
        
        mapView.delegate = self
        restaurantName2 = ""
        addRestaurantAnnotations()
        setRegionToShowAllRestaurants()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        navigationController?.setNavigationBarHidden(true, animated: false)
        let darkMode = UserDefaults.standard.bool(forKey: "Dark/Light_Mode")
        if darkMode {
            self.view.backgroundColor = .darkGray
        } else {
            self.view.backgroundColor = .lightGray
        }
    }

    
    func addRestaurantAnnotations() {
        for location in restaurantLocations {
            let annotation = MKPointAnnotation()
            annotation.title = location.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            mapView.addAnnotation(annotation)
        }
    }
    
    func setRegionToShowAllRestaurants() {
        var minLat = restaurantLocations[0].latitude
        var maxLat = restaurantLocations[0].latitude
        var minLon = restaurantLocations[0].longitude
        var maxLon = restaurantLocations[0].longitude
        
        for location in restaurantLocations {
            minLat = min(minLat, location.latitude)
            maxLat = max(maxLat, location.latitude)
            minLon = min(minLon, location.longitude)
            maxLon = max(maxLon, location.longitude)
        }
    
        let latPadding = (maxLat - minLat) * 0.4
        let lonPadding = (maxLon - minLon) * 0.4
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: (minLat + maxLat) / 2,
                longitude: (minLon + maxLon) / 2
            ),
            span: MKCoordinateSpan(
                latitudeDelta: maxLat - minLat + latPadding,
                longitudeDelta: maxLon - minLon + lonPadding
            )
        )
        
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        if let restaurantName = annotation.title ?? "" {
            print("Selected Restaurant: \(restaurantName)")
            
            let alert = UIAlertController(
                title: "Do you want to place an order for this store?",
                message: "\(restaurantName)",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Correct", style: .default, handler: { _ in
                self.restaurantName2 = restaurantName
                self.performSegue(withIdentifier: "goToOrder", sender: self)
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in}))

            present(alert, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToOrder" {
            if let destinationVC = segue.destination as? FullOrderViewController {
                destinationVC.restaurantName = restaurantName2
            }
        }
    }
    
}

