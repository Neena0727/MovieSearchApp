

import XCTest
import Alamofire
@testable import MovieSearchApp

final class NetworkLayerTests: XCTestCase {
    
    var networkManager: NetworkManager!

    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
    }

    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }

    func testSearchMoviesSuccess() {
        
        let expectation = self.expectation(description: "Search movies should succeed")
        
        networkManager.searchMovies(query: "Inception") { result in
            switch result {
            case .success(let movies):
                XCTAssertGreaterThan(movies.count, 0, "There should be movies returned from search")
            case .failure(let error):
                XCTFail("Search failed with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testSearchMoviesFailureNoInternet() {
        
        let expectation = self.expectation(description: "Search movies should fail due to no internet")
        
        networkManager.searchMovies(query: "Inception") { result in
            switch result {
            case .success:
                XCTFail("Search should have failed due to no internet connection")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, NetworkError.noInternet.localizedDescription)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetMovieDetailsSuccess() {
        let expectation = self.expectation(description: "Fetching movie details should succeed")

        let movieId = 550
        
        networkManager.getMovieDetails(movieId: movieId) { result in
            switch result {
            case .success(let movieDetail):
                XCTAssertNotNil(movieDetail, "Movie details should not be nil")
                XCTAssertEqual(movieDetail.id, movieId, "Movie ID should match")
            case .failure(let error):
                XCTFail("Failed to fetch movie details: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}
