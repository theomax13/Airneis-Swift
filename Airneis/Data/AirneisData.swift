//
//  AirneisData.swift
//  Airneis
//
//  Created by Théo Maxime on 05/03/2024.
//

import Foundation

struct Category: Identifiable {
	let id: String
    let name: String
	let description: String
    let image: String
}

struct Produit: Identifiable {
	let id: String
	let name: String
	let image: String
	let description: String
	let price: Int
	let stock: Bool
}


