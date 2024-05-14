//
//  AirneisData.swift
//  Airneis
//
//  Created by Théo Maxime on 05/03/2024.
//

import Foundation

struct Category: Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
    let image: String
}

struct Produit: Identifiable, Hashable {
    let id: String
    let name: String
    let image: [String]
    let description: String
    let price: Int
    let stock: Bool
    let material: String
}

struct CartItem: Identifiable {
    var id: String
    var product: Produit
    var count: Int
    init(product: Produit, count: Int) {
        id = UUID().uuidString
        self.product = product
        self.count = count
    }
}
