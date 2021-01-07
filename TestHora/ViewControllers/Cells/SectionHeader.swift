//
//  SectionHeader.swift
//  TestHora
//
//  Created by Denis Svetlakov on 07.01.2021.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "sectionHeader"

    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel

        titleLabel.textColor = .label
        titleLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 22, weight: .bold))

        let stackView = UIStackView(arrangedSubviews: [separator, titleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        addSubview(stackView)

        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),

            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])

        stackView.setCustomSpacing(10, after: separator)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Stop trying to make storyboards happen.")
    }
}

