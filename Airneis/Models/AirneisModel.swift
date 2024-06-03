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

struct OrderRoot: Codable {
	var member: [Order]
}

struct Order: Codable, Identifiable {
	var id: Int
//	var idUser: Int
//	var idAdress: Int
	var date: String
	var priceTotal: Double
//	var orderProduct: Array<String>
	
	var orderNumber: String
	var status: String
	var itemCount: Int
	var year: Int
}

struct Product: Codable, Identifiable {
	var id: Int
	var name: String
	var description: String
	var price: Double
	var stock: Bool
	var category: Array<String>
	var materials: Array<String>
	var images: Array<Int>
}
