//
//  LoginResponse.swift
//  Airneis
//
//  Created by Théo Maxime on 06/05/2024.
//

import Foundation

struct LoginResponse {
	let data: LoginResponseData
}

struct LoginResponseData {
	let username: String
	let exp: Int
	let iat: Int
	let roles: Array<Any>
	let id: Int
}
