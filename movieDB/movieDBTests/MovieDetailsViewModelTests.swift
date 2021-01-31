import XCTest
@testable import movieDB

class MovieDetailsViewModelTests: XCTestCase {
    var movieDetailsViewModel: MovieDetailsViewModel!
    var moviesRepository: MoviesRepositoryMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        moviesRepository = MoviesRepositoryMock()
        movieDetailsViewModel = MovieDetailsViewModel(movie: Movie.stub(), moviesRepository: moviesRepository)
    }

    override func tearDownWithError() throws {
        movieDetailsViewModel = nil
        moviesRepository = nil
        try super.tearDownWithError()
    }

    func testFetchMovieDataCallsRepository() {
        let expectation = XCTestExpectation()
        let completion: (String, DetailsCompletion) -> Void = { id, completion in
            completion(.success(MovieDetails.stub()))
            expectation.fulfill()
        }
        moviesRepository.movieDetailsWithCompletionClosure = completion
        movieDetailsViewModel.fetchMovieData()
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(moviesRepository.movieDetailsWithCompletionCalled)
    }
}
