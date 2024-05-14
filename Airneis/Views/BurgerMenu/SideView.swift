//
//  SideView.swift
//  Airneis
//
//  Created by Théo Maxime on 17/04/2024.
//

import SwiftUI

struct SideView: View {
	@Binding var isShowing: Bool
	var content: AnyView
	var direction: Edge
	
    var body: some View {
		ZStack(alignment: .bottom) {
			if isShowing {
				Color.black // You can have any color you want
					.opacity(0.3)
					.ignoresSafeArea()
				content
					.transition(.move(edge: direction))
					.background(
						Color.white
					)
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
		.ignoresSafeArea()
		.animation(.easeInOut, value: isShowing)
    }
}

//#Preview {
//    SideView()
//}
