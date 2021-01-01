//
//  DetailsViewController.swift
//  TestHora
//
//  Created by Denis Svetlakov on 18.12.2020.
//

import UIKit

class DetailsViewController: UIViewController {
    var details: Place!
    
    private let buttomView = ButtomDetailView().view
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderImage()
        setupButtomView()
        imageView.image = UIImage(named: details.promoImageURL)
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
    
    // Set back button innavigation bar
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
        view.addSubview(buttomView!)
        buttomView!.translatesAutoresizingMaskIntoConstraints = false
        buttomView!.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.frame.height / 4) - 10).isActive = true
        buttomView!.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        buttomView!.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        buttomView!.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}


//        navigationItem.title = "\(details.promoImageURL.replacingOccurrences(of: "_", with: " "))"
