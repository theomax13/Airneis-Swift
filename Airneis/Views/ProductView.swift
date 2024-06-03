//
//  ProductView.swift
//  Airneis
//
//  Created by Théo Maxime on 19/04/2024.
//

import SwiftUI

struct ProductView: View {
    @Environment(\.themeColor) var themeColor: Color
    @Environment(\.dismiss) var dismiss
	@EnvironmentObject var cart: Cart

	@Binding var presentSideMenu: Bool
	@Binding var showResearch: Bool
	@Binding var showCart: Bool
	
//    @State var presentSideMenu = false
	@State private var productViewShow = false
	@State private var selectedProduct: Produit?
	
	@State var subtotal = 0.0

    let produit: Produit

    let produitSimilaire: [Produit] = [
		Produit(id: "1", name: "Billy Blanc Bibliothèque", image: ["BillyBlancBibliothèque", "BillyBlancBibliothèque2", "BillyBlancBibliothèque3"], description: "Bibliothèque Blanche", price: 80, stock: true, material: "Wood"),
		Produit(id: "2", name: "Billy Bibliothèque Corner", image: ["BillyCorner", "BillyCorner2", "BillyCorner3"], description: "Bibliothèque Blanche d'angle", price: 120, stock: true, material: "Wood"),
		Produit(id: "3", name: "Friheten Convertible Sofa Skiftebo DarkGrey", image: ["FrihetenConvertibleSofaSkifteboDarkGrey", "FrihetenConvertibleSofaSkifteboDarkGrey2", "FrihetenConvertibleSofaSkifteboDarkGrey3"], description: "Canapé d'angle Gris foncé", price: 2000, stock: false, material: "Fabric"),
    ]
	
	func addProductToCart(_ product: Produit, cart: Cart) {
		var addNewProduct = true
		for (index, item) in cart.cartItems.enumerated() {
			if item.product.id == product.id {
				cart.cartItems[index].count += 1
				addNewProduct = false
			}
		}
		if addNewProduct {
			cart.cartItems.append(CartItem(product: product, count: 1))
		}
		cart.subtotal += Double(product.price)
	}

    var body: some View {
        VStack {
            NavigationStack {
                ScrollView {
                    Carousel(slides: produit.image, frameHeight: 400)
                    HStack {
                        VStack {
                            Text(produit.name)
                                .font(Font.custom("Comfortaa-Regular", size: 20))
                                .tint(.secondaryWhite)
                            Text(produit.stock == true ? "En stock" : "Stock épuisé")
                                .font(Font.custom("Comfortaa-Regular", size: 14))
                                .tint(.gray)
                        }
                        Text("\(produit.price) €")
                            .padding()
                            .font(Font.custom("Comfortaa-Regular", size: 20))
                            .tint(.secondaryWhite)
                    }

                    VStack {
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur auctor massa nec fermentum ullamcorper.")
                            .font(Font.custom("Comfortaa-Regular", size: 14))
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur auctor massa nec fermentum ullamcorper. Ut maximus tempus velit quis commodo.")
                            .font(Font.custom("Comfortaa-Regular", size: 14))
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur auctor massa nec fermentum ullamcorper. Ut maximus tempus velit quis commodo.")
                            .font(Font.custom("Comfortaa-Regular", size: 14))
                    }
					.padding(.bottom)
					
					if produit.stock == true {
						Button(action: {
							addProductToCart(produit, cart: cart)
						}) {
							Text("Ajouter au panier")
						}
						.accessibilityIdentifier("addToCart")
						.foregroundStyle(.primaryYellow)
						.buttonStyle(.bordered)
					} else {
						Button(action: {}) {
							Text("Stock épuisé")
						}
						.foregroundStyle(.primaryYellow)
						.buttonStyle(.bordered)
					}

                    Text("Produits similaires")
                        .font(Font.custom("Comfortaa-Regular", size: 16))
                        .padding()
					
					ForEach(produitSimilaire) { produit in
						Button(action: {
							self.selectedProduct = produit
							productViewShow = true
						}) {
							ProduitCard(produit: produit, pictureHeight: 300)
								.padding([.leading, .top, .trailing])
						} //: Button
					}
                }
                .background(themeColor)
            }
			.navigationDestination(isPresented: $productViewShow) {
				if selectedProduct != nil {
//					ProductView(produit: selectedProduct!)
					ProductView(presentSideMenu: $presentSideMenu, showResearch: $showResearch, showCart: $showCart, produit: selectedProduct!)
				} else {
					ParamsView(presentSideMenu: $presentSideMenu, showResearch: $showResearch, showCart: $showCart)
				}
			}
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.title)
                        .foregroundStyle(.primaryYellow)
                        .tint(.secondaryWhite)
                }
				.accessibilityIdentifier("BackButton")
            }
        }
    }
}

//#Preview {
//    ProductView(produit: Produit(id: "3", name: "Friheten Convertible Sofa Skiftebo DarkGrey", image: ["FrihetenConvertibleSofaSkifteboDarkGrey", "FrihetenConvertibleSofaSkifteboDarkGrey2", "FrihetenConvertibleSofaSkifteboDarkGrey3"], description: "Canapé d'angle Gris foncé", price: 2000, stock: true))
//}
