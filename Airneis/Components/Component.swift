//
//  Component.swift
//  Airneis
//
//  Created by Théo Maxime on 05/03/2024.
//

import Foundation
import SwiftUI

//MARK: Card Modifier
struct CardBackground: ViewModifier {
	func body(content: Content) -> some View {
		content
			.background(Color("CardBackground"))
			.cornerRadius(20)
			.shadow(color: Color.black.opacity(0.2), radius: 4)
	}
}

struct CategoryCard: View {
	let category: Category
	var body: some View {
		VStack {
			ZStack {
				Image(category.image)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(height: 80)
					.clipped()
			}
			
			VStack(spacing: 0.0) {
				HStack {
					Text(category.name)
				}
				.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
				.padding([.leading, .bottom])
			}
		}
		.background(Color(.tertiarySystemFill))
		.cornerRadius(12)
	}
}

struct ProduitCard: View {
	let produit: Produit
	var body: some View {
		VStack {
			ZStack {
				Image(produit.image)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(height: 80)
					.clipped()
			}
			
			VStack(spacing: 0.0) {
				HStack {
					Text(produit.name)
						.fontWeight(.bold)
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.leading)
				
				HStack {
					Text(produit.description)
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding([.leading, .bottom])
					
					Text("\(produit.price) €")
						.frame(maxWidth: .infinity, alignment: .trailing)
						.padding([.trailing, .bottom])
				}
			}
		}
		.background(Color(.tertiarySystemFill))
		.cornerRadius(12)
	}
}
//
//#Preview {
//	CategoryCard(category: categorie1).previewLayout(.sizeThatFits)
//}



