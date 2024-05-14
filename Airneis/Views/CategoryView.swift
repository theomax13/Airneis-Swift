//
//  GlobalProduct.swift
//  Airneis
//
//  Created by Théo Maxime on 07/03/2024.
//

import SwiftUI

struct CategoryView: View {
    @Environment(\.themeColor) var themeColor: Color
	@Binding var presentSideMenu: Bool
	@Binding var showResearch: Bool
	@Binding var cartViewShow: Bool
	
	@State var selectedSideMenuTab = 999

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
                    // MARK: Header

					Header(presentSideMenu: $presentSideMenu, showResearch: $showResearch, selectedSideMenuTab: $selectedSideMenuTab)

                    Image("\(category.image)")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .ignoresSafeArea()
                    //			.padding(.leading)
                    Text("\(category.name)")
                        .padding()
                        .font(Font.custom("Comfortaa-Regular", size: 20))
                        .tint(.secondaryWhite)
                    Text("\(category.description)")
                        .font(Font.custom("Comfortaa-Regular", size: 14))
                        .tint(.secondaryWhite)

                    Spacer()
                    VStack {
                        ForEach(produits) { produit in
							ProduitCard(produit: produit, pictureHeight: 300)
								.padding([.leading, .top, .trailing])
                        }
                    }
                }.background(themeColor)
            }
        }
    }
}

//#Preview {
//    CategoryView(category: Category(id: "1", name: "Salon", description: "Categorie Salon", image: "Salon"))
//}
