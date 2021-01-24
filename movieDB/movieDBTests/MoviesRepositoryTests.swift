import XCTest
@testable import movieDB

class MoviesRepositoryTests: XCTestCase {

    var moviesRepository: MoviesRepository!
    var moviesServive: MoviesServiceMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        moviesServive = MoviesServiceMock()
        moviesRepository = MoviesRepositoryImpl(moviesService: moviesServive)
    }

    override func tearDownWithError() throws {
        moviesServive = nil
        moviesRepository = nil
        try super.tearDownWithError()
    }

    func testSuccessWithEmptyResponse() throws {
        let expectation = XCTestExpectation()
        let completion :(Int, @escaping MoviesListCompletion) -> Void = { page, completion in
            completion(.success(MoviesDTO.stub()))
        }
        moviesServive.moviesWithCompletionClosure = completion
        moviesRepository.movies { (result) in
            guard case .success(let value) = result else {
                return XCTFail("Expected to be a success but got a failure with \(result)")
            }
            XCTAssertEqual(value,[])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testSuccessWithNonEmptyResponse() throws {
        let expectation = XCTestExpectation()
        let completion :(Int, @escaping MoviesListCompletion) -> Void = { page, completion in
            completion(.success( MoviesDTO.stub(movies: [MovieDTO.stub()])) )
        }
        moviesServive.moviesWithCompletionClosure = completion
        moviesRepository.movies { (result) in
            guard case .success(let value) = result else {
                return XCTFail("Expected to be a success but got a failure with \(result)")
            }
            XCTAssertEqual(value,[Movie.stub()])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testFailureResponse() throws {
        let expectation = XCTestExpectation()
        let completion :(Int, @escaping MoviesListCompletion) -> Void = { page, completion in
            completion(.failure(.badURL))
        }
        moviesServive.moviesWithCompletionClosure = completion
        moviesRepository.movies { (result) in
            guard case .failure(let error) = result else {
                return XCTFail("Expected to be a success but got a success with \(result)")
            }
            XCTAssertEqual(error, MoviesServiceError.badURL)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
