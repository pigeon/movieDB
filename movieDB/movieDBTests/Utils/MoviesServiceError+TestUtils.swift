import Foundation
@testable import movieDB

extension MoviesServiceError: Equatable {}

public func ==(lhs: MoviesServiceError, rhs: MoviesServiceError) -> Bool {
    switch (lhs, rhs) {
    case (.badURL, .badURL):
        return true
    case (.unknown, .unknown):
        return true
    case (.httpError, .httpError):
        return true
    case (.apiError(let error1), .apiError(let error2)):
        let nsError1 = error1 as NSError
        let nsError2 = error2 as NSError
        return nsError1 == nsError2
    default:
        return false
    }
}
