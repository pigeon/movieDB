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
    default:
        return false
    }
}
