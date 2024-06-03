//
//  CommandesView.swift
//  Airneis
//
//  Created by Théo Maxime on 17/05/2024.
//

import SwiftUI

struct OrdersView: View {
    @ObservedObject var viewModel: OrderViewModel

    @Binding var presentSideMenu: Bool
    @Binding var showResearch: Bool
	@Binding var showCart: Bool

    @State var selectedSideMenuTab = 2

    var body: some View {
        NavigationView {
            VStack {
				Header(presentSideMenu: $presentSideMenu, showResearch: $showResearch, presentCart: $showCart)
                ScrollView {
                    Text("Mes commandes")
                        .font(Font.custom("Comfortaa-Regular", size: 24))
                    VStack(alignment: .leading) {
						ForEach(viewModel.orders) { order in
							OrderRowView(viewModel: viewModel, order: order)
								.padding(.horizontal)
								.padding(.bottom, 5)
								.accessibilityIdentifier("DetailCommande")
						}
					}
//                        ForEach(groupOrdersByYear(), id: \.key) { year, orders in
//                            Section(header: Text("\(year)")
//                                .font(Font.custom("Comfortaa-Regular", size: 24))
//                                .foregroundColor(.white)
//                                .padding(.top)) {
//                                    ForEach(orders) { order in
//                                        OrderRowView(order: order)
//                                            .padding(.horizontal)
//                                            .padding(.bottom, 5)
//											.accessibilityIdentifier("DetailCommande")
//                                    }
//                                }
//                        }
                    }
                    .padding()
                }
				.background(Color.primaryBlue)
				.task {
					await viewModel.fetchOrders()
				}
            }
        }
    }

//    private func groupOrdersByYear() -> [(key: Int, value: [Order])] {
//        let groupedOrders = Dictionary(grouping: viewModel.orders, by: { $0.year })
//        return groupedOrders.sorted(by: { $0.key > $1.key })
//    }
//}

// #Preview {
//	OrdersView()
// }
