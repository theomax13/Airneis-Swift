//
//  SideMenuView.swift
//  Airneis
//
//  Created by Théo Maxime on 17/04/2024.
//

import SwiftUI

enum SideMenuRowTypeLogged: Int, CaseIterable {
	case home = 0
	case commande
	case params
	case cgu
	case mention
	case contact
	case about
	case logout
	
	var title: String {
		switch self {
			case .home:
				return "Home"
			case .commande:
				return "Mes commandes"
			case .params:
				return "Mes paramètres"
			case .cgu:
				return "CGU"
			case .mention:
				return "Mentions Légales"
			case .contact:
				return "Contact"
			case .about:
				return "À propos d’ÀIRNEIS"
			case .logout:
				return "Se déconnecter"
		}
	}
	
	var iconName: String {
		switch self {
			case .home:
				return "house"
			case .commande:
				return "shippingbox"
			case .params:
				return "gear"
			case .cgu:
				return "doc.text"
			case .mention:
				return "scroll"
			case .contact:
				return "envelope"
			case .about:
				return "info.circle"
			case .logout:
				return "arrow.right.square"
		}
	}
}

enum SideMenuRowType: Int, CaseIterable {
    case home = 0
	case login
	case register
	case cgu
    case mention
    case contact
    case about

    var title: String {
		switch self {
			case .home:
				return "Home"
			case .login:
				return "Se connecter"
			case .register:
				return "S'inscrire"
			case .cgu:
				return "CGU"
			case .mention:
				return "Mentions Légales"
			case .contact:
				return "Contact"
			case .about:
				return "À propos d’ÀIRNEIS"
		}
    }

    var iconName: String {
        switch self {
        case .home:
            return "house"
		case .login:
			return "person"
		case .register:
			return "person.badge.plus"
        case .cgu:
            return "doc.text"
		case .mention:
			return "scroll"
        case .contact:
            return "envelope"
        case .about:
            return "info.circle"
        }
    }
}

struct SideMenuView: View {
	@EnvironmentObject var loginModel: LoginViewModel
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool

    var body: some View {
        HStack {
            Spacer()

            ZStack {
                Rectangle()
                    .fill(.primaryBlue)
                    .frame(width: 270)
                    .shadow(color: .primaryYellow.opacity(0.1), radius: 5, x: -5, y: 0)

                VStack(alignment: .trailing, spacing: 0) {
                    ProfileImageView()
                        .frame(height: 140)
                        .padding(.bottom, 30)

						ForEach(SideMenuRowTypeLogged.allCases, id: \.self) { row in
							RowView(isSelected: selectedSideMenuTab == row.rawValue, imageName: row.iconName, title: row.title) {
								selectedSideMenuTab = row.rawValue
								print(selectedSideMenuTab)
								presentSideMenu.toggle()
							}
						}

                    Spacer()
                }
                .padding(.top, 100)
                .frame(width: 270)
                .background(
                    Color.primaryBlue
                )
            }
        }
        .background(.clear)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }

    func ProfileImageView() -> some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                Image("profile-image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(.primaryYellow.opacity(0.5), lineWidth: 10)
                    )
                    .cornerRadius(50)
                Spacer()
            }

            Text("MAXIME Théo")
				.font(Font.custom("Comfortaa-Bold", size: 18))
                .foregroundColor(.white)

            Text("Airneis")
				.font(Font.custom("Comfortaa-SemiBold", size: 14))
                .foregroundColor(.white.opacity(0.5))
        }
    }

    func RowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (() -> Void)) -> some View {
        Button {
            action()
        } label: {
			VStack(alignment: .leading) {
				HStack(spacing: 20) {
					Rectangle()
						.fill(.primaryBlue)
						.frame(width: 5)
					ZStack {
						Image(systemName: imageName)
							.resizable()
							.renderingMode(.template)
							.foregroundColor(isSelected ? .secondaryYellow : .white)
							.frame(width: 26, height: 26)
					}
					.frame(width: 30, height: 30)
					Text(title)
						.font(Font.custom("Comfortaa-Regular", size: 14))
						.foregroundColor(isSelected ? .secondaryYellow : .white)
					Spacer()
					Rectangle()
						.fill(isSelected ? .primaryYellow : .primaryBlue)
						.frame(width: 5)
				}
			}
        }
		.accessibilityIdentifier(imageName)
        .frame(height: 50)
        .background(
            LinearGradient(colors: [isSelected ? .primaryYellow.opacity(0.5) : .primaryBlue, .primaryBlue], startPoint: .trailing, endPoint: .leading)
        )
    }
}

// #Preview {
//    SideMenuView()
// }
