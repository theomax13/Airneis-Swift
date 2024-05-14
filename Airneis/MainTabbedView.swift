//
//  MainTabbedView.swift
//  Airneis
//
//  Created by Théo Maxime on 17/04/2024.
//

import SwiftUI

struct MainTabbedView: View {
	@ObservedObject var cart: Cart
	@EnvironmentObject var loginModel: LoginViewModel
	
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
	@State var showResearch = false
	@State var cartViewShow = false

    var body: some View {
        ZStack {
//			if loginModel.loginState {
				switch selectedSideMenuTab {
					case 0: HomeView(presentSideMenu: $presentSideMenu, showResearch: $showResearch)
					case 1: CommandesView(presentSideMenu: $presentSideMenu, showResearch: $showResearch, showHeader: true)
					case 2: ParamsView(presentSideMenu: $presentSideMenu, showResearch: $showResearch)
					case 3: CGUView(presentSideMenu: $presentSideMenu, showResearch: $showResearch)
					case 4: MentionView(presentSideMenu: $presentSideMenu, showResearch: $showResearch)
					case 5: ContactView(presentSideMenu: $presentSideMenu, showResearch: $showResearch)
					case 6: AboutView(presentSideMenu: $presentSideMenu, showResearch: $showResearch)
					case 7: LogoutView(presentSideMenu: $presentSideMenu, showResearch: $showResearch)
					default: EmptyView()
				}

                SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
//            } else {
//				switch selectedSideMenuTab {
//					case 0: HomeView(presentSideMenu: $presentSideMenu, showResearch: $showResearch)
//					case 1: LoginView(presentSideMenu: $presentSideMenu, showResearch: $showResearch)
//					case 2: RegisterView(presentSideMenu: $presentSideMenu, showResearch: $showResearch)
//					case 3: CGUView(presentSideMenu: $presentSideMenu, showResearch: $showResearch)
//					case 4: MentionView(presentSideMenu: $presentSideMenu, showResearch: $showResearch)
//					case 5: ContactView(presentSideMenu: $presentSideMenu, showResearch: $showResearch)
//					case 6: AboutView(presentSideMenu: $presentSideMenu, showResearch: $showResearch)
//					default: EmptyView()
//				}
//
//                SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
//            }
        }
    }
}
