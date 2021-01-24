import XCTest
@testable import movieDB

class MovieServiceTests: XCTestCase {

    var movieService: MoviesService!
    var httpSession: HTTPSessionMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        httpSession = HTTPSessionMock()
        movieService = MoviesServiceImpl(apiKey: "", session: httpSession)
    }

    override func tearDownWithError() throws {
        httpSession = nil
        movieService = nil
        try super.tearDownWithError()
    }

    func testServiceSuccess() throws {
        //httpSession.dataTaskWithCompletionHandlerClosure =
        //httpSession.dataTaskWithCompletionHandlerReturnValue = 
    }
}
