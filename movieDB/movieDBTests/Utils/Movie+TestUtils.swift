import XCTest
@testable import movieDB

extension Movie {
    static func stub() -> Movie {
        guard let movie =  Movie(url: "https://image.tmdb.org/t/p/w500/poster_path", title: "title", overview: "", vote: 7.0, date: "", id: 1) else {
            XCTFail("Expected to get non nil value")
            fatalError("Unexpected situation")
        }
        return movie
    }
}
