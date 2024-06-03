//
//  OrderViewModel.swift
//  Airneis
//
//  Created by Théo Maxime on 17/05/2024.
//

import Foundation

class OrderViewModel: ObservableObject {
    @Published var orders = [Order]()

    var loginViewModel: LoginViewModel
	private var isLoginInProgress = false

    let baseURL: String = "http://127.0.0.1:8000/api"

    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
    }

    func fetchOrders() async {
 		// This should be your actual network fetching logic
		let fetchedOrders = [
			Order(id: 1, date: "22/03/2024", priceTotal: 35, orderNumber: "XXXXXXXXXXXX", status: "Livrée", itemCount: 3, year: 2024),
			Order(id: 2, date: "15/02/2024", priceTotal: 50, orderNumber: "YYYYYYYYYYYY", status: "En cours", itemCount: 2, year: 2024),
			Order(id: 3, date: "12/12/2023", priceTotal: 25, orderNumber: "ZZZZZZZZZZZZ", status: "Annulée", itemCount: 1, year: 2023),
			Order(id: 4, date: "11/11/2022", priceTotal: 100, orderNumber: "AAAAAAAAAAAA", status: "Livrée", itemCount: 4, year: 2022),
			// Add more orders as needed
		]
		
		// Ensure updates to @Published properties are done on the main thread
		DispatchQueue.main.async {
			self.orders = fetchedOrders
		}
//        let path = "/orders"
//
//        //		let url = URL(baseURL + path)
//        guard let url = URL(string: baseURL + path) else {
//            print("URL invalid")
//            return
//        }
//
//        var request = URLRequest(url: url)
//
//		request.addValue("application/ld+json", forHTTPHeaderField: "Content-Type")
//		
//		if let token = UserDefaults.standard.string(forKey: "jwtToken") {
//			request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
//		} else {
//			print("No token found. Redirecting to login.")
//			await retryLoginAndFetchOrders()
//			return
//		}
////		request.printDetails()
////		request.printTokenExpiry()
//
//        do {
//            let (data, response) = try await URLSession.shared.data(from: url)
//
//            if let httpResponse = response as? HTTPURLResponse {
//				print(httpResponse)
//                switch httpResponse.statusCode {
//                case 200:
//                    do {
//                        let decodeResponse = try JSONDecoder().decode(OrderRoot.self, from: data)
//                        DispatchQueue.main.async {
//                            self.orders = decodeResponse.member
//                        }
//                    } catch {
//                        print("JSON decoding error: \(error)")
//                    }
//
//                case 401:
//						print("Unauthorized access. Retrying login.")
//						await retryLoginAndFetchOrders()
//
//                default:
//					print("HTTP Error: Status code is " + String(httpResponse.statusCode))
//                }
//            }
//        } catch {
//            print("Network Request error : \(error)")
//        }
    }
	
	private func retryLoginAndFetchOrders() async {
		guard !isLoginInProgress else {
			print("Login is already in progress. Aborting retry.")
			return
		}
		
		isLoginInProgress = true
		DispatchQueue.main.async {
			self.loginViewModel.login(completion: { response in
				print("Login response: \(response)")
			}, onSuccess: {
				self.isLoginInProgress = false
				Task {
					await self.fetchOrders()
				}
			})
		}
	}

    func fetchOrderById(id: Int) async {
        let path = "/orders/" + String(id)

        //		let url = URL(baseURL + path)
        guard let url = URL(string: baseURL + path) else {
            print("URL invalid")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "get"

        request.addValue("application/ld+json", forHTTPHeaderField: "Content-Type")
        if let tokenPayload = UserDefaults.standard.dictionary(forKey: "tokenPayload") {
            request.addValue("Bearer \(tokenPayload)", forHTTPHeaderField: "Authorization")
        }

		do {
			let (data, response) = try await URLSession.shared.data(from: url)
			
			if let httpResponse = response as? HTTPURLResponse {
				switch httpResponse.statusCode {
					case 200:
						do {
							let decodeResponse = try JSONDecoder().decode(OrderRoot.self, from: data)
							DispatchQueue.main.async {
								self.orders = decodeResponse.member
							}
						} catch {
							print("JSON decoding error: \(error)")
						}
						
					case 401:
						DispatchQueue.main.async {
							self.loginViewModel.login(completion: { response in
								print("Login response: \(response)")
							}, onSuccess: {
								Task {
									await self.fetchOrderById(id: id)
								}
							})
						}
						
					default:
						print("HTTP Error: Status code is not 200")
						print(httpResponse.statusCode)
				}
			}
		} catch {
			print("Network Request error : \(error)")
		}
    }
}
