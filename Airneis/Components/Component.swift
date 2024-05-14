//
//  Component.swift
//  Airneis
//
//  Created by Théo Maxime on 05/03/2024.
//

import Foundation
import SwiftUI

// MARK: Card Modifier

struct CardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color("CardBackground"))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 4)
    }
}

// MARK: CategoryCard

struct CategoryCard: View {
    let category: Category

    var body: some View {
//        NavigationLink(destination: GlobalProduct(category: category)) {
        VStack {
            ZStack {
                Image(category.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 110)
                    .clipped()
            }

            VStack(spacing: 0.0) {
                HStack {
                    Text(category.name)
                        .font(Font.custom("Comfortaa-Regular", size: 14))
                        .tint(.secondaryWhite)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.bottom, .top, .horizontal], 9)
            }
        }
        .background(Color(.tertiarySystemFill))
        .cornerRadius(12)
//        }
    }
}

// MARK: ProduitCard

struct ProduitCard: View {
    let produit: Produit
    let pictureHeight: CGFloat?

    var body: some View {
        VStack {
            ZStack {
                Image(produit.image[0])
                    .resizable()
                    .scaledToFit()
                    .frame(height: pictureHeight)
                    .clipped()
            }
            VStack(spacing: 0.0) {
                HStack {
                    Text(produit.name)
                        .font(Font.custom("Comfortaa-Regular", size: 14))
                        .fontWeight(.bold)
                        .tint(.secondaryWhite)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)

                HStack {
                    Text(produit.description)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.custom("Comfortaa-Regular", size: 14))
                        .padding([.leading, .bottom])
                        .tint(.secondaryWhite)

                    Text("\(produit.price) €")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(Font.custom("Comfortaa-Regular", size: 14))
                        .padding([.trailing, .bottom])
                        .tint(.secondaryWhite)
                }
            }
        }
        .background(Color(.tertiarySystemFill))
        .cornerRadius(12)
    }
}

// MAARK: CartCard

struct CartCard: View {
    @Binding var cartItem: CartItem

    var body: some View {
        HStack {
            Image(cartItem.product.image[0])
                .resizable().frame(width: 100, height: 100).clipShape(Circle())
            VStack(alignment: .leading) {
                Text(cartItem.product.name).fontWeight(.semibold)
                Text("\(cartItem.product.price) €")
                Button("Show details") {}.foregroundColor(.gray)
            }
            Spacer()
            Text("\(cartItem.count)")
        }
    }
}

// MARK: CartSummary

struct CartSummary: View {
	@Environment(\.themeColor) var themeColor: Color
	
    @Binding var subtotal: Double
    
	var body: some View {
		VStack {
			HStack {
				Text("HT")
				Spacer()
				Text(String(format: "$%.2f", subtotal))
			}
			HStack {
				Text("TVA")
				Spacer()
				Text(String(format: "$%.2f", subtotal * 0.2))
			}
			HStack {
				Text("Total")
				Spacer()
				Text(String(format: "$%.2f", subtotal + subtotal * 0.2))
			}
			
			Button(action: {}) {
				Text("Passer au paiement")
			}
			.foregroundColor(.primaryYellow)
			.buttonStyle(.bordered)
		}
        .background(themeColor)
    }
}

// MARK: Header

struct Header: View {
    @Environment(\.themeColor) var themeColor: Color
    @Binding var presentSideMenu: Bool
    @Binding var showResearch: Bool
	@Binding var selectedSideMenuTab: Int

    var body: some View {
        NavigationStack {
            HStack {
                Text("Àirneis")
                    .font(Font.custom("Macondo-Regular", size: 24))
                    .padding()
                Spacer()
                Button(action: {
                    showResearch.toggle()
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                        .foregroundColor(.primaryYellow)
                }
                Button(action: {
					selectedSideMenuTab = 1
				}) {
                    Image(systemName: "cart")
                        .font(.title3)
                        .foregroundColor(.primaryYellow)
                }
                Button(action: {
                    presentSideMenu.toggle()
                }) {
                    Image(systemName: "line.3.horizontal")
                        .font(.title3)
                        .foregroundColor(.primaryYellow)
                        .padding(.trailing)
                } //: Button
            } //: HStack
            .background(themeColor)
            Spacer()
        } //: NavigationStack
        .frame(height: 50)
    }
}

// MARK: Carousel

struct Carousel: View {
    @State private var currentIndex = 0

    let slides: [String]
    let frameHeight: CGFloat

    init(slides: [String] = ["image1", "image2", "image3"], frameHeight: CGFloat = 180) {
        self.slides = slides
        self.frameHeight = frameHeight
    }

    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ZStack(alignment: .trailing) {
                Image(slides[currentIndex])
                    .resizable()
                    .frame(height: frameHeight)
                    .scaledToFit()
                    .cornerRadius(15)
            }
            HStack {
                ForEach(0 ..< slides.count) { index in
                    Circle()
                        .fill(self.currentIndex == index ? Color(.primaryYellow) : Color(.gray))
                        .frame(width: 10, height: 10)
                }
            }
            .padding()
        }
        .padding()
        .onReceive(timer) { _ in
            withAnimation {
                currentIndex = currentIndex < slides.count - 1 ? currentIndex + 1 : 0
            }
        }
    }
}

//
// #Preview {
//	CategoryCard(category: categorie1).previewLayout(.sizeThatFits)
// }
