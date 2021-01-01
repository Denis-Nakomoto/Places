//
//  ButtomDetailView.swift
//  TestHora
//
//  Created by Denis Svetlakov on 01.01.2021.
//

import UIKit

class ButtomDetailView: UIViewController {
    
    let placeName: UILabel = {
        let placeName = UILabel()
        placeName.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        placeName.textColor = .label
        placeName.text = "placeName"
        return placeName
    }()
    
    let placeDescription: UILabel = {
        let placeDescription = UILabel()
        placeDescription.font = UIFont.preferredFont(forTextStyle: .subheadline)
        placeDescription.textColor = .lightGray
        placeDescription.text = "placeDescription"
        return placeDescription
    }()
    
    let discount: UILabel = {
        let discount = UILabel()
        discount.font = UIFont.preferredFont(forTextStyle: .title2)
        discount.textColor = .label
        return discount
    }()
    
    let rating: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        setupConstraints()
    }
    
    // Setup constraints
    private func setupConstraints() {
        let nameAndDescriptionStackView = UIStackView(arrangedSubviews: [placeName, placeDescription])
        nameAndDescriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        nameAndDescriptionStackView.axis = .vertical
        nameAndDescriptionStackView.alignment = .center
        nameAndDescriptionStackView.spacing = 15
        view.addSubview(nameAndDescriptionStackView)

        NSLayoutConstraint.activate([
            nameAndDescriptionStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameAndDescriptionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameAndDescriptionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameAndDescriptionStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ])
    }
}


