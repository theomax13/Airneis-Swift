//
//  CategoryView2.swift
//  Airneis
//
//  Created by Théo Maxime on 19/04/2024.
//

import SwiftUI

struct CategoryView2: View {
    @Environment(\.themeColor) var themeColor: Color
    @Environment(\.dismiss) var dismiss

    @Binding var presentSideMenu: Bool
	@Binding var showResearch: Bool
//	@Binding var cartViewShow: Bool
//    @State var presentSideMenu = false
	
	@State private var selectedProduct: Produit?
	@State private var productViewShow = false

    let category: Category

    let produits: [Produit] = [
		Produit(id: "1", name: "Billy Blanc Bibliothèque", image: ["BillyBlancBibliothèque", "BillyBlancBibliothèque2", "BillyBlancBibliothèque3"], description: "Bibliothèque Blanche", price: 80, stock: true, material: "Wood"),
		Produit(id: "2", name: "Billy Bibliothèque Corner", image: ["BillyCorner", "BillyCorner2", "BillyCorner3"], description: "Bibliothèque Blanche d'angle", price: 120, stock: true, material: "Wood"),
		Produit(id: "3", name: "Friheten Convertible Sofa Skiftebo DarkGrey", image: ["FrihetenConvertibleSofaSkifteboDarkGrey", "FrihetenConvertibleSofaSkifteboDarkGrey2", "FrihetenConvertibleSofaSkifteboDarkGrey3"], description: "Canapé d'angle Gris foncé", price: 2000, stock: true, material: "Fabric"),
    ]

    var body: some View {
        VStack {
            NavigationStack {
                ScrollView {
					Image("\(category.image)")
						.resizable()
						.scaledToFill()
						.frame(height: 200)
						.ignoresSafeArea()
						.padding(.bottom)
                    Text("\(category.name)")
                        .padding()
                        .font(Font.custom("Comfortaa-Regular", size: 20))
                        .tint(.secondaryWhite)
                    Text("\(category.description)")
                        .font(Font.custom("Comfortaa-Regular", size: 14))
                        .tint(.secondaryWhite)
                    VStack {
                        ForEach(produits) { produit in
							Button(action: {
								self.selectedProduct = produit
								productViewShow = true
							}) {
								ProduitCard(produit: produit, pictureHeight: 300)
									.padding([.leading, .top, .trailing])
							} //: Button
                        }
                    }
					Spacer()
                }
				.ignoresSafeArea()
				.background(themeColor)
            }
			.navigationDestination(isPresented: $productViewShow) {
				if selectedProduct != nil {
//					ProductView(produit: selectedProduct!)
					ProductView(presentSideMenu: $presentSideMenu, showResearch: $showResearch, produit: selectedProduct!)
				} else {
					ParamsView(presentSideMenu: $presentSideMenu, showResearch: $showResearch)
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
            }
        }
    }
}

//#Preview {
//    CategoryView2(category: Category(id: "1", name: "Salon", description: "Categorie Salon", image: "Salon"))
//}
