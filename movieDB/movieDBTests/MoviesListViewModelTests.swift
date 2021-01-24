import XCTest
@testable import movieDB

class MoviesListViewModelTests: XCTestCase {

    var moviesListViewModel: MoviesListViewModel!
    var moviesRepository: MoviesRepositoryMock!
    var moviesListViewDelegate: MoviesListViewDelegateMock!
    var router: RouterMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        moviesRepository = MoviesRepositoryMock()
        router = RouterMock()
        moviesListViewDelegate = MoviesListViewDelegateMock()
        moviesListViewModel = MoviesListViewModel(router: router, moviesRepository: moviesRepository)
        moviesListViewModel.moviesListViewDelegate = moviesListViewDelegate
    }

    override func tearDownWithError() throws {
        moviesListViewDelegate = nil
        moviesRepository = nil
        router = nil
        moviesListViewModel = nil
        try super.tearDownWithError()
    }

    func testLoadDataSuccess() {
        let expectation = XCTestExpectation()
        let completion: (@escaping MoviesPageCompletion) -> Void = { completion in
            completion(.success([Movie.stub()]))
            expectation.fulfill()
        }

        moviesRepository.moviesCompletionClosure = completion
        moviesListViewModel.loadData()
        XCTAssertTrue(moviesListViewDelegate.updateWithCalled)
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(moviesListViewDelegate.updateWithCallsCount, 2)
        XCTAssertEqual(moviesListViewDelegate.updateWithReceivedViewState, .content)
        XCTAssertEqual(moviesListViewModel.numberOfItemsInSection, 1)
    }

    func testLoadDataIfNeededDoesntGetCalled() {
        let expectation = XCTestExpectation()
        let completion: (@escaping MoviesPageCompletion) -> Void = { completion in
            completion(.success([Movie.stub(), Movie.stub(), Movie.stub()]))
            expectation.fulfill()
        }

        moviesRepository.moviesCompletionClosure = completion
        moviesListViewModel.loadData()
        wait(for: [expectation], timeout: 1.0)
        moviesListViewModel.loadDataIfNeeded(with: 0)
        XCTAssertEqual(moviesRepository.moviesCompletionCallsCount, 1)
    }

    func testLoadDataIfNeededGetCalled() {
        let expectation = XCTestExpectation()
        let completion: (@escaping MoviesPageCompletion) -> Void = { completion in
            completion(.success([Movie.stub(), Movie.stub(), Movie.stub()]))
            expectation.fulfill()
        }

        moviesRepository.moviesCompletionClosure = completion
        moviesListViewModel.loadData()
        wait(for: [expectation], timeout: 1.0)
        moviesListViewModel.loadDataIfNeeded(with: 2)
        XCTAssertEqual(moviesRepository.moviesCompletionCallsCount, 2)
    }

    func testLoadDataFailure() {
        let expectation = XCTestExpectation()
        let completion: (@escaping MoviesPageCompletion) -> Void = { completion in
            completion(.failure(.httpError))
            expectation.fulfill()
        }

        moviesRepository.moviesCompletionClosure = completion
        moviesListViewModel.loadData()
        XCTAssertTrue(moviesListViewDelegate.updateWithCalled)
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(moviesListViewDelegate.updateWithCallsCount, 2)
        XCTAssertEqual(moviesListViewDelegate.updateWithReceivedViewState, .error("Request to MovieDB failed. Try again later"))
    }

    func testUserSelectedMovie() {
        let expectation = XCTestExpectation()
        let completion: (@escaping MoviesPageCompletion) -> Void = { completion in
            completion(.success([Movie.stub()]))
            expectation.fulfill()
        }

        moviesRepository.moviesCompletionClosure = completion
        moviesListViewModel.loadData()
        wait(for: [expectation], timeout: 1.0)
        moviesListViewModel.selectItem(with: 0)
        XCTAssertTrue(router.navigateToDetailsListCalled)
    }

    func testGetMovieWithIndex() {
        let expectation = XCTestExpectation()
        let completion: (@escaping MoviesPageCompletion) -> Void = { completion in
            completion(.success([Movie.stub()]))
            expectation.fulfill()
        }
        moviesRepository.moviesCompletionClosure = completion
        moviesListViewModel.loadData()
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(moviesListViewModel.getMovie(with: 0),Movie.stub())
    }
}
