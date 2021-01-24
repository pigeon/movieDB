import XCTest
@testable import movieDB


class MovieServiceTests: XCTestCase {

    var movieService: MoviesService!
    var httpSession: HTTPNetworkSessionMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        httpSession = HTTPNetworkSessionMock()
        movieService = MoviesServiceImpl(apiKey: "", session: httpSession)
    }

    override func tearDownWithError() throws {
        httpSession = nil
        movieService = nil
        try super.tearDownWithError()
    }

    func testMovieListApiFailure() throws {
        let nsError = NSError(domain: "test error", code: Int.max - 1, userInfo: nil)
        let expectation = XCTestExpectation()
        httpSession.error = nsError
        movieService.movies(with: 1) { result in
            guard case .failure(let error) = result else {
                return XCTFail("Expected to be a failure but got a success with \(result)")
            }
            XCTAssertEqual(error, .apiError(nsError))
            expectation.fulfill() 
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testMovieListApiSuccess() throws {
        let expectedValue = MoviesDTO.stub(movies: [MovieDTO.stub()])
        let expectation = XCTestExpectation()
        httpSession.urlResponse = HTTPURLResponse(url: URL(string: "google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        httpSession.data = try JSONEncoder().encode(expectedValue)
        movieService.movies(with: 1) { result in
            guard case .success(let value) = result else {
                return XCTFail("Expected to be a success but got a failure with \(result)")
            }
            XCTAssertEqual(value, expectedValue)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testMovieDetailsApiFailure() throws {
        let nsError = NSError(domain: "test error", code: Int.max - 1, userInfo: nil)
        let expectation = XCTestExpectation()
        httpSession.error = nsError
        movieService.movieDetails(with: "") { result in
            guard case .failure(let error) = result else {
                return XCTFail("Expected to be a failure but got a success with \(result)")
            }
            XCTAssertEqual(error, .apiError(nsError))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testMovieDetailsApiSuccess() throws {
        let expectedValue = MovieDetailsDTO.stub()
        let expectation = XCTestExpectation()
        httpSession.urlResponse = HTTPURLResponse(url: URL(string: "google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        httpSession.data = try JSONEncoder().encode(expectedValue)
        movieService.movieDetails(with: "") { result in
            guard case .success(let value) = result else {
                return XCTFail("Expected to be a success but got a failure with \(result)")
            }
            XCTAssertEqual(value, expectedValue)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
