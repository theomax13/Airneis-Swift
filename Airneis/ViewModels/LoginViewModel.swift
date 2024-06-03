//
//  LoginViewModel.swift
//  Airneis
//
//  Created by Théo Maxime on 06/05/2024.
//

import Foundation
import JWTDecode

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
	
	private var session: URLSession
	
	init(session: URLSession = .shared) {
		self.session = session
	}

    func login(completion: @escaping (Result<LoginResponse, Error>) -> Void, onSuccess: @escaping () -> Void) {
		let parameters = LoginRequest(email: email, password: password)
		let scheme: String = "http"
		let host: String = "127.0.0.1"
		let port = 8000
		let path = "/auth"
		
		var components = URLComponents()
		components.scheme = scheme
		components.host = host
		components.port = port
		components.path = path
		
		guard let url = components.url else { return }
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		
		do {
			request.httpBody = try JSONEncoder().encode(parameters)
		} catch {
			completion(.failure(error))
			return
		}

		let task = session.dataTask(with: request) { data, _, error in
			if let error = error {
				DispatchQueue.main.async {
					completion(.failure(error))
				}
				return
			}
			
			guard let data = data else {
				DispatchQueue.main.async {
					completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
				}
				return
			}
			
			do {
				let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
				guard let token = json["token"] as? String else {
					DispatchQueue.main.async {
						completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token not found"])))
					}
					return
				}
				UserDefaults.standard.set(token, forKey: "jwtToken")
				DispatchQueue.main.async {
					onSuccess()
					completion(.success(LoginResponse(token: token)))
				}
			} catch {
				DispatchQueue.main.async {
					completion(.failure(error))
				}
			}
		}
		task.resume()
    }
}
