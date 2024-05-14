//
//  LoginRequest.swift
//  Airneis
//
//  Created by Théo Maxime on 06/05/2024.
//

import Foundation

struct LoginRequest: Encodable {
	let email: String
	let password: String
}
