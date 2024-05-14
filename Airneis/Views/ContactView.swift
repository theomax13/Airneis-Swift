//
//  ContactView.swift
//  Airneis
//
//  Created by Théo Maxime on 17/04/2024.
//

import SwiftUI

struct ContactView: View {
	@Binding var presentSideMenu: Bool
	@Binding var showResearch: Bool
//	@Binding var cartViewShow: Bool
	
	@State var selectedSideMenuTab = 5
	
	var body: some View {
		VStack{
			Header(presentSideMenu: $presentSideMenu, showResearch: $showResearch, selectedSideMenuTab: $selectedSideMenuTab)
			
			Spacer()
			Text("Contact View")
			Spacer()
		}
		.padding(.horizontal, 24)
	}
}
