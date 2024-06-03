//
//  CartView.swift
//  Airneis
//
//  Created by Théo Maxime on 17/04/2024.
//

import SwiftUI

struct CartView: View {
	@Environment(\.themeColor) var themeColor: Color
	@Environment(\.dismiss) var dismiss
	@EnvironmentObject var cart: Cart
	
	@State private var selectedProduct: Produit?
	@State private var productViewShow = false
	@State var selectedSideMenuTab = 1
	
	@Binding var presentSideMenu: Bool
	@Binding var showResearch: Bool
	@Binding var showCart: Bool
	
	var showHeader = true
	
	var body: some View {
		VStack{
			if showHeader == true {
				Header(presentSideMenu: $presentSideMenu, showResearch: $showResearch, presentCart: $showCart)
			}
			
			NavigationStack {				
				List($cart.cartItems) { $cartItem in
					CartCard(cartItem:  $cartItem)
						.padding([.leading, .top, .trailing])
						.listRowBackground(Color.thirdBlue)
				}
				.listRowBackground(Color.thirdBlue)
				.background(themeColor)
				.scrollContentBackground(.hidden)
				CartSummary(subtotal: $cart.subtotal)
			}
			.padding(.horizontal, 24)
			.background(themeColor)
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
			}
		}
	}
}

