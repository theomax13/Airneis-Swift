//
//  AirneisApp.swift
//  Airneis
//
//  Created by Théo Maxime on 14/02/2024.
//

import SwiftUI

@main
struct AirneisApp: App {
	@AppStorage("loginState") private var isLogged: Bool = false
	
	let loginViewModel = LoginViewModel()
	let cart = Cart()
	
    var body: some Scene {
        WindowGroup {
			MainTabbedView(cart: cart)
				.environmentObject(cart)
				.environmentObject(loginViewModel)
				.applyThemeBackground()
				.environment(\.themeColor, Color("PrimaryBlue"))
				.preferredColorScheme(.dark)
        }
    }
}

struct ThemeColorKey: EnvironmentKey {
	static let defaultValue: Color = Color("PrimaryBlue")  // Default to PrimaryBlue
}

extension EnvironmentValues {
	var themeColor: Color {
		get { self[ThemeColorKey.self] }
		set { self[ThemeColorKey.self] = newValue }
	}
}

struct GlobalBackgroundModifier: ViewModifier {
	@Environment(\.themeColor) var themeColor: Color
	
	func body(content: Content) -> some View {
		content
			.background(themeColor.edgesIgnoringSafeArea(.all))
	}
}

extension View {
	func applyThemeBackground() -> some View {
		self.modifier(GlobalBackgroundModifier())
	}
}
