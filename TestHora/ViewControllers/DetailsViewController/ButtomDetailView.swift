//
//  ButtomDetailView.swift
//  TestHora
//
//  Created by Denis Svetlakov on 01.01.2021.
//

import UIKit
import Cosmos
import MapKit

class ButtomDetailView: UIViewController {
    
    private let regionInMetres = 10000.0
    var locationManager: CLLocationManager!
    
    var placeName: UILabel = {
        let placeName = UILabel()
        placeName.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        placeName.textColor = .label
        placeName.text = "placeName"
        return placeName
    }()
    
    var placeDescription: UILabel = {
        let placeDescription = UILabel()
        placeDescription.font = UIFont.preferredFont(forTextStyle: .subheadline)
        placeDescription.textColor = .lightGray
        placeDescription.text = "placeDescription"
        return placeDescription
    }()
    
    var placeSlogon: UILabel = {
        let placeSlogon = UILabel()
        placeSlogon.font = UIFont.preferredFont(forTextStyle: .subheadline)
        placeSlogon.textColor = .lightGray
        placeSlogon.textColor = .label
        placeSlogon.numberOfLines = 0
 
        return placeSlogon
    }()
    
    let discountImage: UIImageView = {
        let discountImage = UIImageView()
        discountImage.image = UIImage(systemName: "tag")
        discountImage.contentMode = .left
        discountImage.tintColor = .green
        return discountImage
    }()
    
    let discountStaticLabel: UILabel = {
        let discount = UILabel()
        discount.text = "Ваша скидка:" 
        return discount
    }()
    
    var discount: UILabel = {
        let discount = UILabel()
        discount.font = UIFont.preferredFont(forTextStyle: .body)
        discount.textColor = .label
        discount.text = "20%"
        return discount
    }()
    
    var rating: CosmosView = {
        let imageView = CosmosView()
        return imageView
    }()
    
    var separator: UIView = {
        let separator = UIView(frame: .zero)
        separator.backgroundColor = .quaternaryLabel
        return separator
    }()
    
    let menuButton: UIButton = {
       let menuButton = UIButton()
        menuButton.layer.cornerRadius = 10
        menuButton.backgroundColor = .white
        menuButton.layer.borderWidth = 1
        menuButton.layer.borderColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        menuButton.setTitleColor(.systemGreen, for: .normal)
        menuButton.setTitle("Menu", for: .normal)
        return menuButton
    }()
    
    var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }()
    
    let userLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        button.addTarget(self, action: #selector (userLocationButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // Setup view background depending on dark or light theme
    var viewBackgroung: UIColor = {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return .darkGray
                } else {
                    return .white
                }
            }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = viewBackgroung
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        setupConstraints()
    }
    
    @objc func userLocationButtonPressed() {
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion(center: location,
                                            latitudinalMeters: regionInMetres,
                                            longitudinalMeters: regionInMetres)
            mapView.setRegion(region, animated: true)
        }
    }
    
    // Setup constraints
    private func setupConstraints() {
        
        let nameAndDescriptionStackView = UIStackView(arrangedSubviews: [placeName, placeDescription])
        nameAndDescriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        nameAndDescriptionStackView.axis = .vertical
        nameAndDescriptionStackView.alignment = .center
        nameAndDescriptionStackView.spacing = 10
        view.addSubview(nameAndDescriptionStackView)

        NSLayoutConstraint.activate([
            nameAndDescriptionStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameAndDescriptionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameAndDescriptionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameAndDescriptionStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ])
        
        view.addSubview(placeSlogon)
        placeSlogon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            placeSlogon.topAnchor.constraint(equalTo: nameAndDescriptionStackView.bottomAnchor, constant: 20),
            placeSlogon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            placeSlogon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
        
        let discountStackView = UIStackView(arrangedSubviews: [discountImage, discountStaticLabel, discount])
        discountStackView.translatesAutoresizingMaskIntoConstraints = false
        discountStackView.alignment = .center
        discountStackView.spacing = 5
        view.addSubview(discountStackView)

        NSLayoutConstraint.activate([
            discountStackView.topAnchor.constraint(equalTo: placeSlogon.bottomAnchor, constant: 20),
            discountStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        let ratingStackView = UIStackView(arrangedSubviews: [separator, rating])
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        ratingStackView.alignment = .center
        ratingStackView.spacing = 5
        view.addSubview(ratingStackView)

        NSLayoutConstraint.activate([
            separator.widthAnchor.constraint(equalToConstant: 1),
            separator.heightAnchor.constraint(equalTo: discountStackView.heightAnchor),
            ratingStackView.heightAnchor.constraint(equalTo: discountStackView.heightAnchor),
            ratingStackView.topAnchor.constraint(equalTo: placeSlogon.bottomAnchor, constant: 20),
            ratingStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(menuButton)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuButton.heightAnchor.constraint(equalToConstant: 50),
            menuButton.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 20),
            menuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
            menuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55)
        ])
        
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: menuButton.bottomAnchor, constant: 20),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        mapView.addSubview(userLocationButton)
        userLocationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userLocationButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -40),
            userLocationButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -40)
        ])
    }
}


// MARK: - SwiftUI
import SwiftUI

struct FarmCellProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = ButtomDetailView()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<FarmCellProvider.ContainerView>) -> ButtomDetailView {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: FarmCellProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<FarmCellProvider.ContainerView>) {
            
        }
    }
}


