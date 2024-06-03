//
//  AirneisUITests.swift
//  AirneisUITests
//
//  Created by Théo Maxime on 18/05/2024.
//

import XCTest

final class AirneisUITests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		continueAfterFailure = false
		XCUIApplication().launch()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func testNavigation() {
		let app = XCUIApplication()
		
		// Accéder à la vue principale
		app.buttons["sideMenuButton"].tap()
		app.buttons["house"].tap()
		XCTAssertTrue(app.staticTexts["Venant des hautes terres d'écosse nos meubles sont immortels"].exists)
		
		// Naviguer vers la vue category
		app.buttons["Salon"].tap()
		XCTAssertTrue(app.staticTexts["Salon"].exists)
		
		// Naviguer vers un produit
		app.buttons["Billy Blanc Bibliothèque"].tap()
		XCTAssertTrue(app.buttons["addToCart"].exists)
	}

	func testAddToCart() {
		let app = XCUIApplication()
		
		// Accéder à la vue des produits
		app.buttons["Salon"].tap()
		app.buttons["Billy Blanc Bibliothèque"].tap()
		
		// Sélectionner un produit (assurez-vous que les identifiants d'accessibilité sont définis)
		app.buttons["addToCart"].tap()
		app.buttons["BackButton"].tap()
		app.buttons["BackButton"].tap()
		
		// Vérifier que le produit est ajouté au panier
		app.buttons["cart"].tap()
		XCTAssertTrue(app.staticTexts["Billy Blanc Bibliothèque"].exists)
	}
	
	func testListeCommandes() {
		let app = XCUIApplication()
		
		app.buttons["sideMenuButton"].tap()
		app.buttons["shippingbox"].tap()
		
		XCTAssertTrue(app.staticTexts["Livrée"].exists)
	}

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
