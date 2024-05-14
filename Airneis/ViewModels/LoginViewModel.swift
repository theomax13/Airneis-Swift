//
//  LoginViewModel.swift
//  Airneis
//
//  Created by Théo Maxime on 06/05/2024.
//

import Foundation

class LoginViewModel: ObservableObject {
	@Published var loginState = false
	@Published var email: String = ""
	@Published var password: String = ""
	
	func login() {
		LoginAction(
			parameters: LoginRequest(
				email: email,
				password: password
			)
		).call { _ in
			self.loginState = true
			print("Login success")
		}
	}
}
