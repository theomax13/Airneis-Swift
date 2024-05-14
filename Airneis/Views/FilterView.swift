//
//  RechercheView.swift
//  Airneis
//
//  Created by Théo Maxime on 29/04/2024.
//

import SwiftUI

struct FilterView: View {
	@Environment(\.themeColor) var themeColor: Color
	
	@Binding var presentSideMenu: Bool
	@Binding var showResearch: Bool
//	@Binding var cartViewShow: Bool
	
	@State var searchText: String = ""
	@State var searchprixMin: String = ""
	@State var searchprixMax: String = ""
	@State private var selectedProduct: Produit?
	@State private var productViewShow = false
	@State private var selectedMaterials: Set<MaterialToggle> = []
	@State private var stockFilter = false
	
	let produits: [Produit] = [
		Produit(id: "1", name: "Billy Blanc Bibliothèque", image: ["BillyBlancBibliothèque", "BillyBlancBibliothèque2", "BillyBlancBibliothèque3"], description: "Bibliothèque Blanche", price: 80, stock: true, material: "Wood"),
		Produit(id: "2", name: "Billy Bibliothèque Corner", image: ["BillyCorner", "BillyCorner2", "BillyCorner3"], description: "Bibliothèque Blanche d'angle", price: 120, stock: true, material: "Wood"),
		Produit(id: "3", name: "Friheten Convertible Sofa Skiftebo DarkGrey", image: ["FrihetenConvertibleSofaSkifteboDarkGrey", "FrihetenConvertibleSofaSkifteboDarkGrey2", "FrihetenConvertibleSofaSkifteboDarkGrey3"], description: "Canapé d'angle Gris foncé", price: 2000, stock: false, material: "Fabric"),
	]
	
	struct MaterialToggle: Hashable {
		let material: String
		var isSelected: Bool
		
		func hash(into hasher: inout Hasher) {
			hasher.combine(material)
		}
		
		static func == (lhs: MaterialToggle, rhs: MaterialToggle) -> Bool {
			return lhs.material == rhs.material
		}
	}
	
	var uniqueMaterials: [MaterialToggle] {
		Array(Set(produits.map { MaterialToggle(material: $0.material, isSelected: false) }))
	}
	
	var body: some View {
		NavigationStack {
			ScrollView {
				List {
					Section(header: Text("Price")) {
						TextField("Prix min €", text: $searchprixMin)
							.keyboardType(.numberPad)
						TextField("Prix max €", text: $searchprixMax)
							.keyboardType(.numberPad)
					}
					.listRowBackground(Color.thirdBlue)
					
					Section(header: Text("Materials")) {
						ForEach(uniqueMaterials, id: \.self) { material in
							Toggle(isOn: Binding<Bool>(
								get: { self.selectedMaterials.contains(material) },
								set: { if $0 { self.selectedMaterials.insert(material) } else { self.selectedMaterials.remove(material) } }
							)) {
								Text(material.material)
							}
							.tint(.primaryYellow)
							.id(material)
						}
					}
					.listRowBackground(Color.thirdBlue)
					
					Section(header: Text("Stock")) {
						Toggle(isOn: $stockFilter) {
							Text("Only show available")
						}
						.tint(.primaryYellow)
					}
					.listRowBackground(Color.thirdBlue)
				}
				.frame(height: 400)
				.foregroundColor(.thirdWhite)
				.background(themeColor)
				.scrollContentBackground(.hidden)
				
				ForEach(filteredProduct) { produit in
					Button(action: {
						self.selectedProduct = produit
						productViewShow = true
					}) {
						ProduitCard(produit: produit, pictureHeight: 300)
							.padding([.leading, .top, .trailing])
					}
				}
			}
			.background(themeColor)
			.navigationTitle("Search")
			.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
			.navigationDestination(isPresented: $productViewShow) {
				if selectedProduct != nil {
					ProductView(presentSideMenu: $presentSideMenu, showResearch: $showResearch, produit: selectedProduct!)
				} else {
					ParamsView(presentSideMenu: $presentSideMenu, showResearch: $showResearch)
				}
			}
		}
	}
	
	var filteredProduct: [Produit] {
		let minPrice = Int(searchprixMin) ?? 0
		let maxPrice = Int(searchprixMax) ?? Int.max
		let selectedMaterials = self.selectedMaterials.filter { $0.isSelected }.map { $0.material }
		
		return produits.filter { produit in
			let isMatchingText = searchText.isEmpty || produit.name.lowercased().contains(searchText.lowercased())
			let isMatchingPriceRange = minPrice <= produit.price && produit.price <= maxPrice
			let isMatchingMaterial = selectedMaterials.isEmpty || selectedMaterials.contains(produit.material)
			let isMatchingStock = !stockFilter || produit.stock
			
			return isMatchingText && isMatchingPriceRange && isMatchingMaterial && isMatchingStock
		}
    }
}

// #Preview {
//	FilterView()
// }
