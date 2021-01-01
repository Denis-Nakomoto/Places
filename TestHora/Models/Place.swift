//
//  Place.swift
//  TestHora
//
//  Created by Denis Svetlakov on 17.12.2020.
//

import Foundation

struct Places: Codable {
    let places: [Place]
}

struct Place: Codable {
    let promoImageURL: String
    let id: Int
    let menu: [Menu]
}

struct Menu: Codable {
    let id, sortOrder: Int
    let name: String
    let dishes: [Dish]
}

struct Dish: Codable {
    let id, sortOrder: Int
    let imageURL, name, weight: String
    let price: Int
    let discount: Double
}
