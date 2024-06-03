//
//  HomeView.swift
//  Airneis
//
//  Created by Théo Maxime on 14/02/2024.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.themeColor) var themeColor: Color
    @Binding var presentSideMenu: Bool
	@Binding var showResearch: Bool
	@Binding var showCart: Bool
//	@Binding var cartViewShow: Bool
	
	@State var selectedMaterials: Set<Produit> = []
	@State var selectedSideMenuTab = 0
    @State private var selectedCategory: Category?
    @State private var categoryViewShow = false
	@State private var showHeader = true

    let categories: [Category] = [
        Category(id: "1", name: "Salon", description: "Categorie Salon", image: "Salon"),
        Category(id: "2", name: "Kitchen", description: "Categorie Cuisine", image: "Kitchen"),
        Category(id: "3", name: "Bedroom", description: "Categorie Chambre", image: "Bedroom"),
        Category(id: "4", name: "Bathroom", description: "Categorie Salle de bain", image: "Bathroom"),
        Category(id: "5", name: "Dining room", description: "Categorie Salle a manger", image: "Diningroom"),
    ]

    let produits: [Produit] = [
		Produit(id: "1", name: "Billy Blanc Bibliothèque", image: ["BillyBlancBibliothèque", "BillyBlancBibliothèque2", "BillyBlancBibliothèque3"], description: "Bibliothèque Blanche", price: 80, stock: true, material: "Wood"),
		Produit(id: "2", name: "Billy Bibliothèque Corner", image: ["BillyCorner", "BillyCorner2", "BillyCorner3"], description: "Bibliothèque Blanche d'angle", price: 120, stock: true, material: "Wood"),
		Produit(id: "3", name: "Friheten Convertible Sofa Skiftebo DarkGrey", image: ["FrihetenConvertibleSofaSkifteboDarkGrey", "FrihetenConvertibleSofaSkifteboDarkGrey2", "FrihetenConvertibleSofaSkifteboDarkGrey3"], description: "Canapé d'angle Gris foncé", price: 2000, stock: true, material: "Fabric"),
    ]

    var rows: Int {
        (categories.count + 1) / 2
    }

    var login = true

    var body: some View {
        ZStack {
            VStack {
                NavigationStack {
                    ScrollView {
						// MARK: Header
						
						Header(presentSideMenu: $presentSideMenu, showResearch: $showResearch, presentCart: $showCart)
                        // MARK: Carousel

                        Carousel()
                        Text("Venant des hautes terres d'écosse nos meubles sont immortels")
                            .font(Font.custom("Comfortaa-Regular", size: 20))
                            .multilineTextAlignment(.center)
                            .padding()
                            .tint(.secondaryWhite)
                        Spacer()

                        // MARK: Category

                        VStack {
							ForEach(categories) { category in
                                HStack {
									Button(action: {
										self.selectedCategory = category
										categoryViewShow = true
									}) {
										CategoryCard(category: category)
											.padding([.leading, .trailing])
									} //: Button
									.accessibilityIdentifier(category.name)
								} //: ForEach
							} //: HStack
                        } //: VStack
                        Text("Les Highlanders du moment")
                            .font(Font.custom("Comfortaa-Regular", size: 20))
                            .multilineTextAlignment(.center)
                            .padding()
                            .tint(.secondaryWhite)

                        // MARK: Produits

                        VStack {
                            ForEach(0 ..< self.rows, id: \.self) { rowIndex in
                                HStack {
                                    ForEach(0 ..< 2) { columnIndex in
                                        let index = rowIndex * 2 + columnIndex
                                        if index < self.produits.count {
											ProduitCard(produit: self.produits[index], pictureHeight: 80)
                                                .padding(columnIndex == 0 ? .leading : .trailing, 10)
                                                .if(index == self.produits.count - 1 && self.produits.count % 2 != 0) {
                                                    $0.padding(.trailing, 10)
                                                }
                                        } //: if
                                    } //: ForEach
                                } //: HStack
                            } //: ForEach
                        } //: VStack
                    } //: NavigationStack
                    .navigationDestination(isPresented: $categoryViewShow) {
                        if selectedCategory != nil {
//                            CategoryView2(category: selectedCategory!)
							CategoryView2(presentSideMenu: $presentSideMenu, showResearch: $showResearch, showCart: $showCart, category: selectedCategory!)
                        } else {
							ParamsView(presentSideMenu: $presentSideMenu, showResearch: $showResearch, showCart: $showCart)
                        }
                    }
					.navigationDestination(isPresented: $showCart) {
						CartView(presentSideMenu: $presentSideMenu, showResearch: $showResearch, showCart: $showCart, showHeader: false)
						
					}
                    .background(themeColor)
                }
            } //: VStack
			.sheet(isPresented: $showResearch) {
				FilterView(presentSideMenu: $presentSideMenu, showResearch: $showResearch, showCart: $showCart)
					.background(themeColor)
			}
//			.sheet(isPresented: $cartViewShow) {
//				CartView(presentSideMenu: $presentSideMenu, showResearch: $showResearch, showHeader: false)
//			}
        } //: ZStack
    } //: body
}

extension View {
    @ViewBuilder func `if`<TrueContent: View>(_ condition: Bool, transform: (Self) -> TrueContent) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
} //: Extension
