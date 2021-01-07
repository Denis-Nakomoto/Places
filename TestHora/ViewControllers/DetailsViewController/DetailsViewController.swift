//
//  DetailsViewController.swift
//  TestHora
//
//  Created by Denis Svetlakov on 18.12.2020.
//

import UIKit
import MapKit
import CoreLocation

class DetailsViewController: UIViewController {
    
    var details: Place!
    let locationManager = CLLocationManager()
    private let annotationIdentfier = "annotationIdentfier"
    private var bottomView = ButtomDetailView()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderImage()
        setupButtomView()
        setupPlaceInfo()
        setupPlacemark()
        checkLocationServices()
        bottomView.locationManager = locationManager
        bottomView.details = details
        imageView.image = UIImage(named: details.promoImageURL)
        bottomView.mapView.delegate = self
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    // Set navigation bar when return to places view cotnroller
    override func viewWillDisappear(_ animated: Bool) {
        PlacesViewController().setupNavigationBar()
    }
    
    // Setup navigation bar for current view
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(white: 1, alpha: 0)
        appearance.shadowColor = .none
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        addBackButton()
    }
    
    // Set back button in navigation bar
    private func addBackButton() {
        let backButton: UIButton = UIButton()
        let image = UIImage(systemName: "chevron.backward");
        backButton.setImage(image, for: .normal)
        backButton.sizeToFit()
        backButton.addTarget(self, action: #selector (backButtonPressed), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    // Set all the labels
    private func setupPlaceInfo() {
        bottomView.placeName.text = details.promoImageURL.replacingOccurrences(of: "_", with: " ")
        bottomView.placeDescription.text = details.description
        bottomView.placeSlogon.text = details.slogon
        var discountString = String(format: "%.f", (details.discount * 100))
        discountString.insert(contentsOf: "%", at: discountString.endIndex)
        bottomView.rating.rating = details.rating
        
    }
}

extension DetailsViewController {
    
    // Set constraints for top image
    private func setupHeaderImage() {
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.frame.height) * 3 / 4).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    // Set constraints for buttom view
    private func setupButtomView() {
        view.addSubview(bottomView.view)
        bottomView.view.translatesAutoresizingMaskIntoConstraints = false
        bottomView.view.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.frame.height / 4) - 10).isActive = true
        bottomView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    // Alert method
    private func allertController(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// Setup map view
extension DetailsViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    // Setup map annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        var annotationView = bottomView.mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentfier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentfier)
            annotationView?.canShowCallout = true
        }
        let placeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        placeImageView.layer.cornerRadius = 10
        placeImageView.clipsToBounds = true
        placeImageView.image = UIImage(named: details.promoImageURL)
        placeImageView.contentMode = .scaleAspectFill
        annotationView?.rightCalloutAccessoryView = placeImageView
        return annotationView
    }
    
    // Setup placemark appearance on the map
    private func setupPlacemark() {
        guard let location = details.location else { return }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error)
                return
            }
            guard let placemarks = placemarks else {return}
            let placemark = placemarks.first
            let annotation = MKPointAnnotation()
            annotation.title = self.details.promoImageURL
            guard let placeLocation = placemark?.location else {return}
            annotation.coordinate = placeLocation.coordinate
            self.bottomView.mapView.showAnnotations([annotation], animated: true)
            self.bottomView.mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    // Check if location services is enabled and what is permission and what is preferred accuracy
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManagerDidChangeAuthorization(locationManager)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.allertController(
                    title: "Location services are disabled",
                    message: "To enable it: Got to -> Settings -> Privacy-> Location services and turn On")
            }
        }
    }
    
    // Method observs for the location premission and accuracy
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            bottomView.mapView.showsUserLocation = true
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .denied:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.allertController(title: "Access to your location is denied", message: "To enable the service go to Settings -> Privacy -> turn it On")
            }
            break
        case .restricted:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.allertController(title: "Access to your location is restricted", message: "To allow full acccess go to Settings -> Privacy -> turn it On")
            }
            break
        @unknown default:
            print ("new case is available")
        }
        
        switch manager.accuracyAuthorization {
        case .fullAccuracy:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            break
        case .reducedAccuracy:
            locationManager.desiredAccuracy = kCLLocationAccuracyReduced
            break
        default:
            break
        }
    }
}

