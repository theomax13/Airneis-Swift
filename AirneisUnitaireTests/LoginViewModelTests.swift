//
//  LoginViewModelTests.swift
//  AirneisUnitaireTests
//
//  Created by Théo Maxime on 18/05/2024.
//

@testable import Airneis
import XCTest

class LoginViewModelTests: XCTestCase {
    var loginViewModel: LoginViewModel!

    override func setUp() {
        super.setUp()
        loginViewModel = LoginViewModel(session: makeMockSession())
    }

    override func tearDown() {
        loginViewModel = nil
        super.tearDown()
    }

    func testInitialValues() {
        XCTAssertEqual(loginViewModel.email, "")
        XCTAssertEqual(loginViewModel.password, "")
    }

    func testLoginURLConstruction() {
        let parameters = LoginRequest(email: "theo@theo", password: "theoAdmin")
        let scheme: String = "http"
        let host: String = "127.0.0.1"
        let port = 8000
        let path = "/auth"

        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path

        guard let url = components.url else {
            XCTFail("URL construction failed")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch {
            XCTFail("Request parameter encoding failed")
        }

        XCTAssertEqual(request.url, url)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Accept"), "application/json")
    }

    func testLoginSuccess() {
        let expectation = self.expectation(description: "Login success")

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let jsonResponse = ["token": "valid.jwt.token"]
            let data = try! JSONSerialization.data(withJSONObject: jsonResponse, options: [])
            return (response, data)
        }

        loginViewModel.login(completion: { result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.token, "valid.jwt.token")
                XCTAssertEqual(UserDefaults.standard.string(forKey: "jwtToken"), "valid.jwt.token")
                expectation.fulfill()
            case let .failure(error):
                XCTFail("Login failed with error: \(error)")
            }
        }, onSuccess: {
        })

        waitForExpectations(timeout: 5, handler: nil)
    }

    // Helper function to create a mock URLSession
    private func makeMockSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }
}
