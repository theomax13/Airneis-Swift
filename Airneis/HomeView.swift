//
//  HomeView.swift
//  Airneis
//
//  Created by Théo Maxime on 14/02/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
		ZStack {
			VStack {
				//MARK: Header
				NavigationStack {
					HStack {
						Text("Àirneis")
							.font(Font.custom("Macondo-Regular",size: 24))
							.padding()
						Spacer()
						Button(action: {}) {
							Image(systemName: "magnifyingglass")
								.font(.title3)
								.foregroundColor(.blue)
						}
						Button(action: {}) {
							Image(systemName: "cart")
								.font(.title3)
								.foregroundColor(.blue)
						}
						Button(action: {
//							showMenu.toggle()
						}) {
							Image(systemName: "line.3.horizontal")
								.font(.title3)
								.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
								.padding(.trailing)
						}//:Button
					}//:HStack
					Spacer()
				}//:NavigationStack
				//MARK: Carousel
			}//:VStack
		}//:ZStack
    }//:body
}

#Preview {
    HomeView()
}
