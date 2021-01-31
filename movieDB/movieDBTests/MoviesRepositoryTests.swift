import XCTest
@testable import movieDB

class MoviesRepositoryTests: XCTestCase {

    var moviesRepository: MoviesRepository!
    var moviesServive: MoviesServiceMock!
    var cache: CacheMock!
    var connectionManager: ConnectionManagerMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        moviesServive = MoviesServiceMock()
        cache = CacheMock()
        connectionManager = ConnectionManagerMock()
        moviesRepository = MoviesRepositoryImpl(
            moviesService: moviesServive,
            connectionManager: connectionManager,
            cache: cache)
    }

    override func tearDownWithError() throws {
        moviesServive = nil
        moviesRepository = nil
        try super.tearDownWithError()
    }

    func testMoviesListSuccessWithEmptyResponse() throws {
        let expectation = XCTestExpectation()
        let completion :(Int, @escaping MoviesListCompletion) -> Void = { page, completion in
            completion(.success(MoviesDTO.stub()))
        }
        connectionManager.underlyingConnected = true
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

    func testMoviesListSuccessWithNonEmptyResponse() throws {
        let expectation = XCTestExpectation()
        let completion :(Int, @escaping MoviesListCompletion) -> Void = { page, completion in
            completion(.success( MoviesDTO.stub(movies: [MovieDTO.stub()])) )
        }
        connectionManager.underlyingConnected = true
        moviesServive.moviesWithCompletionClosure = completion
        moviesRepository.movies { [weak self] (result) in
            guard case .success(let value) = result else {
                return XCTFail("Expected to be a success but got a failure with \(result)")
            }
            XCTAssertEqual(value,[Movie.stub()])
            XCTAssertEqual(self?.cache.loadObjectWasCalled, false)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testMoviesListGetDataFromCacheIfOffline() throws {
        let expectation = XCTestExpectation()
        let completion :(Int, @escaping MoviesListCompletion) -> Void = { page, completion in
            completion(.success( MoviesDTO.stub(movies: [MovieDTO.stub()])) )
        }
        connectionManager.underlyingConnected = false
        cache.saveReturnValue = [Movie.stub()]
        moviesServive.moviesWithCompletionClosure = completion
        moviesRepository.movies { [weak self] (result) in
            guard case .success(let value) = result else {
                return XCTFail("Expected to be a success but got a failure with \(result)")
            }
            XCTAssertEqual(value,[Movie.stub()])
            XCTAssertEqual(self?.cache.loadObjectWasCalled, true)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testMoviesListFailureResponse() throws {
        let expectation = XCTestExpectation()
        let completion :(Int, @escaping MoviesListCompletion) -> Void = { page, completion in
            completion(.failure(.badURL))
        }
        connectionManager.underlyingConnected = true
        moviesServive.moviesWithCompletionClosure = completion
        moviesRepository.movies { (result) in
            guard case .failure(let error) = result else {
                return XCTFail("Expected to be a failure but got a success with \(result)")
            }
            XCTAssertEqual(error, MoviesServiceError.badURL)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testMovieDetailsFailureResponse() throws {
        let expectation = XCTestExpectation()
        let completion: (String, @escaping MovieDetailsCompletion) -> Void = { id, completion in
            completion(.failure(.httpError))
        }
        connectionManager.underlyingConnected = true
        moviesServive.movieDetailsWithCompletionClosure = completion
        moviesRepository.movieDetails(with: "") { (result) in
            guard case .failure(let error) = result else {
                return XCTFail("Expected to be a failure but got a success with \(result)")
            }
            XCTAssertEqual(error, MoviesServiceError.httpError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testMovieDetailsSuccessWithNonEmptyResponse() throws {
        let expectation = XCTestExpectation()
        let completion: (String, @escaping MovieDetailsCompletion) -> Void = { id, completion in
            completion(.success(MovieDetailsDTO.stub()))
        }
        connectionManager.underlyingConnected = true
        moviesServive.movieDetailsWithCompletionClosure = completion
        moviesRepository.movieDetails(with: "") { (result) in
            guard case .success(let value) = result else {
                return XCTFail("Expected to be a success but got a failure with \(result)")
            }
            XCTAssertEqual(value, MovieDetails.stub())
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
