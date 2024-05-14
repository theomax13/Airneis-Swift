//
//  LoginAction.swift
//  Airneis
//
//  Created by Théo Maxime on 06/05/2024.
//

import Foundation
import JWTDecode

struct LoginAction {
    var parameters: LoginRequest

    func call(completion: @escaping (LoginResponse) -> Void) {
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
        request.httpMethod = "post"

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch {
            print("Error: Unable to encode request parameters")
        }

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
				do {
					// Decode JWT token
					let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
					guard let token = json["token"] as? String else {
						print("Error: Token not found in response")
						return
					}
					let jwt = try decode(jwt: token)
					let tokenPayload = jwt.body
//					return tokenPayload
				} catch {
					print("Error: Unable to decode JWT token")
				}
            } else {
                print("Error: API request failed")

                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
