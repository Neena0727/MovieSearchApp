//
//  MovieSearchAppUITests.swift
//  MovieSearchAppUITests
//
//  Created by Mac on 25/02/25.
//

import XCTest

final class MovieSearchAppUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    func testSearchBarFunctionality() {
        let app = XCUIApplication()
        app.launch()
        
        let searchBar = app.searchFields["Search"]
        XCTAssertTrue(searchBar.exists, "Search bar should be present")
        
        searchBar.tap()
        searchBar.typeText("Inception")
        
        let firstResult = app.tables.cells.firstMatch
        XCTAssertTrue(firstResult.exists, "Search results should be populated")
        
        firstResult.tap()
        
        let movieDetailLabel = app.staticTexts["Movie Details"]
        XCTAssertTrue(movieDetailLabel.exists, "Movie details screen should be displayed")
    }
}
