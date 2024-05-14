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
//	@Binding var cartViewShow: Bool
	
	@State var selectedSideMenuTab = 1
	
	var body: some View {
		VStack{
			Header(presentSideMenu: $presentSideMenu, showResearch: $showResearch, selectedSideMenuTab: $selectedSideMenuTab)
			
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
				action: viewModel.login,
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

