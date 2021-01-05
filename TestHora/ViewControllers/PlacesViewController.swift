//
//  PlacesViewController.swift
//  TestHora
//
//  Created by Denis Svetlakov on 18.12.2020.
//

import UIKit

class PlacesViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PlacesCustomCell.self, forCellReuseIdentifier: PlacesCustomCell.reuseId)
        return tableView
    }()
    
    private var safeArea: UILayoutGuide!
    private var places: Places!
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        setupTableView()
        fetchData()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // Setup table view contraints
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    // Fetching data
    private func fetchData() {
        NetworkManager.shared.parseJson { places in
            self.places = places
        }
    }
    
    // Setup navigation bar
    func setupNavigationBar() {
        
        // Set title for navigation bar
        navigationItem.title = "Places"
        
        // Set large title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Set appearance
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 194/255
        )
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .white
    }
    
    // Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailsViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        detailVC.details = places.places[indexPath.row]
    }
}

// MARK: - Table View delegate and data source

extension PlacesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlacesCustomCell.reuseId, for: indexPath) as! PlacesCustomCell
        let placeName = places.places[indexPath.row].promoImageURL
        let placeDesription = places.places[indexPath.row].description
        cell.nameLabel.text = placeName.replacingOccurrences(of: "_", with: " ")
        cell.detailsLabel.text = placeDesription
        cell.imageOfPlace.image = UIImage(named: places.places[indexPath.row].promoImageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailsViewController()
        detailVC.details = places.places[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // Set row hight
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
