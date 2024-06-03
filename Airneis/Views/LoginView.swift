//
//  LoginView.swift
//  Airneis
//
//  Created by Théo Maxime on 17/04/2024.
//

import SwiftUI

struct LoginView: View {
	@ObservedObject var viewModel: LoginViewModel = LoginViewModel()
	
	@Binding var presentSideMenu: Bool
	@Binding var showResearch: Bool
	@Binding var showCart: Bool
	
	@State var selectedSideMenuTab = 1
	
	var body: some View {
		VStack{
			Header(presentSideMenu: $presentSideMenu, showResearch: $showResearch, presentCart: $showCart)
			
			Spacer()
			
			VStack {
				TextField(
					"Email",
					text: $viewModel.email
				)
				.autocapitalization(.none)
				.disableAutocorrection(true)
				.font(Font.custom("Comfortaa-Regular", size: 17))
				.padding(.top, 20)
				
				Divider()
				
				SecureField(
					"Password",
					text: $viewModel.password
				)
				.font(Font.custom("Comfortaa-Regular", size: 17))
				.padding(.top, 20)
				
				Divider()
			}
			
			Spacer()
			
			Button(
				action: {
					let completion: (Result<LoginResponse, Error>) -> Void = { result in
						switch result {
							case .success(let response):
								print("Login response: \(response)")
							case .failure(let error):
								print("Login failed with error: \(error)")
						}
					}
					let onSuccess: () -> Void = {
						print("Login successful!")
					}
					viewModel.login(completion: completion, onSuccess: onSuccess)
				},
				label: {
					Text("Login")
						.font(Font.custom("Comfortaa-Regular", size: 24))
						.frame(maxWidth: .infinity, maxHeight: 60)
						.foregroundColor(Color.white)
						.background(Color.primaryYellow)
						.cornerRadius(55)
				}
			)

		}
		.padding(.horizontal, 24)
	}
}

