//
//  AirneisModel.swift
//  Airneis
//
//  Created by Théo Maxime on 15/02/2024.
//

import Foundation

struct Categories: Hashable {
    var name: String
    var imageName: String
}

class Cart: ObservableObject {
    @Published var cartItems: [CartItem]
	var subtotal = 0.0
    init() {
        cartItems = []
    }
}
