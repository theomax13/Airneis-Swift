//
//  SideMenu.swift
//  Airneis
//
//  Created by Théo Maxime on 17/04/2024.
//

import SwiftUI

struct SideMenu: View {
	@Binding var isShowing: Bool
	
	var content: AnyView
	var edgeTransition: AnyTransition = .move(edge: .trailing)
	var body: some View {
		ZStack(alignment: .bottom) {
			if isShowing {
				Color.black
					.opacity(0.3)
					.ignoresSafeArea()
					.onTapGesture {
						isShowing.toggle()
					}
				content
					.transition(edgeTransition)
					.background(
						Color.clear
					)
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
		.ignoresSafeArea()
		.animation(.easeInOut, value: isShowing)
	}
}
