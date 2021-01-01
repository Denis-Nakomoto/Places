//
//  PlacesCustomCell.swift
//  TestHora
//
//  Created by Denis Svetlakov on 23.12.2020.
//

import UIKit

class PlacesCustomCell: UITableViewCell {
    
    static let reuseId = "cell"
    
    var imageOfPlace: UIImageView = {
       let imageOfPlace = UIImageView()
        imageOfPlace.layer.borderWidth = 1
        imageOfPlace.layer.borderColor = UIColor.systemGreen.cgColor
        imageOfPlace.contentMode = .scaleAspectFill
        return imageOfPlace
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .label
        nameLabel.font = .systemFont(ofSize: 17, weight: .regular)
        nameLabel.layer.shadowColor = UIColor.black.cgColor
        nameLabel.layer.shadowRadius = 1.0
        nameLabel.layer.shadowOpacity = 0.3
        nameLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        nameLabel.layer.masksToBounds = false
        return nameLabel
    }()

    let detailsLabel: UILabel = {
        let detailsLabel = UILabel()
        detailsLabel.textColor = .lightGray
        detailsLabel.font = .systemFont(ofSize: 10, weight: .light)
        detailsLabel.numberOfLines = 0
        detailsLabel.text = "RRrcdcdndjvn oifojkvn"
        return detailsLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(imageOfPlace)
        addSubview(nameLabel)
        addSubview(detailsLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageOfPlace.frame = CGRect(x: 10,
                                    y: 5,
                                    width: contentView.frame.size.height - 10,
                                    height: contentView.frame.size.height - 10)
        imageOfPlace.layer.cornerRadius = imageOfPlace.frame.size.height / 2
        imageOfPlace.clipsToBounds = true
        
        nameLabel.frame = CGRect(x: 20 + imageOfPlace.frame.size.width,
                                 y: 0 - imageOfPlace.frame.size.height / 4,
                                 width: contentView.frame.size.width / 2,
                                 height: 80)
        
        detailsLabel.frame = CGRect(x: 20 + imageOfPlace.frame.size.width,
                                    y: 0 + imageOfPlace.frame.size.height / 4,
                                    width: contentView.frame.size.width / 2,
                                    height: 80)
    }
}
