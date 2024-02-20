//
//  HomeView.swift
//  Airneis
//
//  Created by Théo Maxime on 14/02/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var currentIndex = 0
	
//	let categories: [Categories] = loadCategories()
	let categories = [
		Categories(name: "Table", imageName: "IkeaTablesDesks"),
		Categories(name: "Etagère", imageName: "Bookcasesshelvingst002"),
		Categories(name: "Canapé", imageName: "IKEASof"),
	]
    let images: [String] = ["BillyBlancBibliothèque", "BillyCorner", "FrihetenConvertibleSofaSkifteboDarkGrey", "SandsbergStigTableSet", "Söderhamn4-PlaceSofaFridtunaBeige"]

    var body: some View {
        ZStack {
            VStack {
                // MARK: Header

                NavigationStack {
                    HStack {
                        Text("Àirneis")
                            .font(Font.custom("Macondo-Regular", size: 24))
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
                                .foregroundColor(/*@START_MENU_TOKEN@*/ .blue/*@END_MENU_TOKEN@*/)
                                .padding(.trailing)
                        } //: Button
                    } //: HStack
                    Spacer()
                } //: NavigationStack
				.frame(height: 50)
				ScrollView {
					// MARK: Carousel
					
					VStack {
						ZStack {
							ForEach(0 ..< images.count, id: \.self) { index in
								Image(images[index])
									.resizable()
									.scaledToFit()
									.frame(width: UIScreen.main.bounds.width)
									.opacity(index == currentIndex ? 1 : 0)
							} //: ForEach
							HStack {
								Button(action: {
									withAnimation {
										currentIndex = (currentIndex - 1 + images.count) % images.count
									}
								}) {
									Image(systemName: "arrow.left.circle.fill")
										.font(.largeTitle)
										.padding()
								}
								.disabled(currentIndex == 0)
								Spacer()
								Button(action: {
									withAnimation {
										currentIndex = (currentIndex + 1) % images.count
									}
								}) {
									Image(systemName: "arrow.right.circle.fill")
										.font(.largeTitle)
										.padding()
								}
								.disabled(currentIndex == images.count - 1)
							} //: HStack
							.padding(.horizontal)
							.frame(alignment: .center)
						} //: ZStack
						.frame(height: 200)
						HStack(spacing: 10) {
							ForEach(0 ..< images.count, id: \.self) { index in
								Circle()
									.frame(width: 10, height: 10)
									.foregroundColor(index == currentIndex ? .black : .gray)
									.onTapGesture {
										withAnimation {
											currentIndex = index
										}
									}
							} //: ForEach
						} //: HStack
						.padding(.top, 10)
					} //: VStack
					Text("Venant des hautes terres d'écosse nos meubles sont immortels")
						.font(Font.custom("Comfortaa-Regular", size: 20))
						.padding()
					Spacer()
					// MARK: Category
					
					ForEach(categories, id: \.name) { category in
						Image(category.imageName)
							.resizable()
							.scaledToFit()
						Text(category.name)
							.font(Font.custom("Comfortaa-Regular", size: 20))
							.padding()
					}//:ForEach
				}//:NavigationStack
            } //: VStack
        } //: ZStack
    } //: body
}

#Preview {
    HomeView()
}
