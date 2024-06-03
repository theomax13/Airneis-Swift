//
//  OrderDetailView.swift
//  Airneis
//
//  Created by Théo Maxime on 17/05/2024.
//

import SwiftUI

struct OrderDetailView: View {
	@ObservedObject var viewModel: OrderViewModel
	let orders: Order
	
	let orderProduct = [
		Product(id: 2, name: "BERGMUND", description: "Grâce à nos recherches et au développement de nouvelles techniques, la chaise vous offre un confort optimal. Pour changer son style, il suffit de remplacer la housse grise par une housse d'une autre couleur ou d'un autre modèle.", price: 89.99, stock: true, category: ["Chaise"], materials: ["Cahier", "Tissu 100% polyester"], images: [10, 11, 12]),
		Product(id: 3, name: "KARLPETTER", description: "Cette chaise rembourrée est particulièrement confortable pour diverses activités : travailler, bricoler ou manger.", price: 49.99, stock: true, category: ["Chaise"], materials: ["Placage lamellé-collé", "Tissu 100% polyester"], images: [13, 14, 15])
		// Add more orders as needed
	]
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 10) {
				Text("Commande #\(orders.orderNumber)")
					.font(Font.custom("Comfortaa-Regular", size: 24))
					
					.foregroundColor(.white)
				Text("\(orders.date) - \(orders.status)")
					.font(Font.custom("Comfortaa-Regular", size: 18))
					.foregroundColor(.white)
				
				ForEach(orderProduct) { product in
					HStack {
						Rectangle()
							.fill(Color.white)
							.frame(width: 50, height: 50)
							.cornerRadius(5)
						VStack(alignment: .leading) {
							Text(product.name)
								.foregroundColor(.white)
							Text("Description")
								.foregroundColor(.white)
						}
						Spacer()
						VStack {
							Text("\(product.price, specifier: "%.2f")€")
								.foregroundColor(.white)
							Text("1")
								.foregroundColor(.white)
						}
					}
					.padding()
					.background(Color.thirdBlue)
					.cornerRadius(10)
				}
				
				Divider()
					.background(Color.white)
				
				HStack {
					Text("Total")
						.foregroundColor(.white)
					Spacer()
					Text("\(orders.priceTotal, specifier: "%.2f")€")
						.foregroundColor(.white)
				}
				.font(Font.custom("Comfortaa-Regular", size: 18))
				.padding(.top, 10)
				
				HStack {
					Text("TVA")
						.foregroundColor(.white)
					Spacer()
					Text("\((orders.priceTotal * 20)/100, specifier: "%.2f")€")
						.foregroundColor(.white)
				}
				.font(Font.custom("Comfortaa-Regular", size: 14))
				
				Divider()
					.background(Color.white)
				
				Text("Adresse de livraison")
					.font(Font.custom("Comfortaa-Regular", size: 18))
					.foregroundColor(.white)
					.padding(.top, 10)
				Text("John SMITH\n13 rue de la Lune\n75004 PARIS\nFRANCE")
					.font(Font.custom("Comfortaa-Regular", size: 14))
					.foregroundColor(.white)
				
				Divider()
					.background(Color.white)
				
				Text("Adresse de livraison")
					.font(Font.custom("Comfortaa-Regular", size: 18))
					.foregroundColor(.white)
					.padding(.top, 10)
				Text("John SMITH\n13 rue de la Lune\n75004 PARIS\nFRANCE")
					.font(Font.custom("Comfortaa-Regular", size: 14))
					.foregroundColor(.white)
				
				Divider()
					.background(Color.white)
				
				Text("Adresse de facturation")
					.font(Font.custom("Comfortaa-Regular", size: 18))
					.foregroundColor(.white)
					.padding(.top, 10)
				Text("John SMITH\n13 rue de la Lune\n75004 PARIS\nFRANCE")
					.font(Font.custom("Comfortaa-Regular", size: 14))
					.foregroundColor(.white)
				
				Divider()
					.background(Color.white)
				
				Text("Mode de paiement")
					.font(Font.custom("Comfortaa-Regular", size: 18))
					.foregroundColor(.white)
					.padding(.top, 10)
				Text("MasterCard")
					.font(Font.custom("Comfortaa-Regular", size: 14))
					.foregroundColor(.white)
				Text("···· ···· ···· 0494")
					.font(Font.custom("Comfortaa-Regular", size: 14))
					.foregroundColor(.white)

				
				Button(action: {
					// Handle return items action
				}) {
					Text("Retourner des articles")
						.font(Font.custom("Comfortaa-Regular", size: 18))
						.foregroundColor(.white)
						.frame(maxWidth: .infinity, minHeight:40, maxHeight: 44)
						.background(Color.yellow)
						.cornerRadius(22)
						.padding(.vertical)
				}
			}
			.padding()
		}
		.background(Color.primaryBlue)
		.task {
			await viewModel.fetchOrderById(id: orders.id)
		}
	}
}

//#Preview {
//    OrderDetailView()
//}
