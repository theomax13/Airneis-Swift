//
//  LogoutView.swift
//  Airneis
//
//  Created by Théo Maxime on 17/04/2024.
//

import SwiftUI

struct LogoutView: View {
	@Binding var presentSideMenu: Bool
	@Binding var showResearch: Bool
	@Binding var showCart: Bool
	
	@State var selectedSideMenuTab = 7
	
	var body: some View {
		VStack{
			Header(presentSideMenu: $presentSideMenu, showResearch: $showResearch, presentCart: $showCart)
			
			Spacer()
			Text("Logout View")
			Spacer()
		}
		.padding(.horizontal, 24)
	}
}


