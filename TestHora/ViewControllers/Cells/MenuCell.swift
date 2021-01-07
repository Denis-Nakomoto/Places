//
//  MenuCell.swift
//  TestHora
//
//  Created by Denis Svetlakov on 06.01.2021.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    static var reuseId: String = "placeCell"
    let dishTitle = UILabel()
    let weight = UILabel()
    let price = UILabel()
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init (frame: frame)
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.backgroundColor = UIColor(red: 0.2, green: 0.3, blue: 0.9, alpha: 0.5)
        setupItems()
        setupConstraints()
    }
    
    // Setup image frame
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 5,
                                    y: 5,
                                    width: contentView.frame.size.height - 10,
                                    height: contentView.frame.size.height - 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
    
    // Configure labels and image data
    func configure(with dish: Dish) {
        dishTitle.text = dish.name
        imageView.image = UIImage(named: dish.imageURL)
        weight.text = dish.weight + "г"
        price.text = String(dish.price) + "₽"
    }
    
    //
    func setupItems() {
        dishTitle.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 23, weight: .bold))
        dishTitle.textColor = .black
        weight.font = UIFont.preferredFont(forTextStyle: .subheadline)
        weight.textColor = .secondaryLabel
        price.font = UIFont.preferredFont(forTextStyle: .title2)
        price.textColor = .label
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    // Setup constraints
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [dishTitle, weight, price])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        
        addSubview(stackView)
        addSubview(imageView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.frame.height + 15),
        ])
    }
}


