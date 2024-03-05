//
//  HomeView.swift
//  Airneis
//
//  Created by Théo Maxime on 14/02/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var currentIndex = 0

    let categories: [Category] = [
        Category(id: "1", name: "Salon", description: "", image: "Salon"),
        Category(id: "2", name: "Kitchen", description: "", image: "Kitchen"),
        Category(id: "3", name: "Bedroom", description: "", image: "Bedroom"),
        Category(id: "4", name: "Bathroom", description: "", image: "Bathroom"),
        Category(id: "5", name: "Dining room", description: "", image: "Diningroom"),
    ]

    let images: [String] = [
        "BillyBlancBibliothèque",
        "BillyCorner",
        "FrihetenConvertibleSofaSkifteboDarkGrey",
        "SandsbergStigTableSet",
        "Söderhamn4-PlaceSofaFridtunaBeige",
    ]

    let produits: [Produit] = [
        Produit(id: "1", name: "Billy Blanc Bibliothèque", image: "BillyBlancBibliothèque", description: "Bibliothèque Blanche", price: 80, stock: true),
        Produit(id: "2", name: "Billy Bibliothèque Corner", image: "BillyCorner", description: "Bibliothèque Blanche d'angle", price: 120, stock: true),
        Produit(id: "3", name: "Friheten Convertible Sofa Skiftebo DarkGrey", image: "FrihetenConvertibleSofaSkifteboDarkGrey", description: "Canapé d'angle Gris foncé", price: 2000, stock: true),
    ]

    var rows: Int {
        (categories.count + 1) / 2
    }

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
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()

                    // MARK: Category

                    VStack {
                        ForEach(0 ..< self.rows, id: \.self) { rowIndex in
                            HStack {
                                ForEach(0 ..< 2) { columnIndex in
                                    // Calculate the actual index in the flat array
                                    let index = rowIndex * 2 + columnIndex
                                    if index < self.categories.count {
                                        CategoryCard(category: self.categories[index])
                                            .padding(.leading, columnIndex == 0 ? 10 : 0)
                                            .padding(.trailing, columnIndex == 1 ? 10 : 0)
                                            .if(index == self.categories.count - 1 && self.categories.count % 2 != 0) {
                                                $0.padding(.trailing, 10)
                                            }
                                    } //: if
                                } //: ForEach
                            } //: HStack
                        } //: ForEach
                    } //: VStack
                    Text("Les Highlanders du moment")
                        .font(Font.custom("Comfortaa-Regular", size: 20))
                        .multilineTextAlignment(.center)
                        .padding()

                    // MARK: Produits

                    VStack {
                        ForEach(0 ..< self.rows, id: \.self) { rowIndex in
                            HStack {
                                ForEach(0 ..< 2) { columnIndex in
                                    let index = rowIndex * 2 + columnIndex
                                    if index < self.produits.count {
                                        ProduitCard(produit: self.produits[index])
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
            } //: VStack
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

#Preview {
    HomeView()
}
