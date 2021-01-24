@testable import movieDB

extension MoviesListViewState: Equatable {}

public func ==(lhs: MoviesListViewState, rhs: MoviesListViewState) -> Bool {
    switch (lhs, rhs) {
    case (.content, .content):
        return true
    case (.loading, .loading):
        return true
    case (.error(let error1), .error(let error2)):
        return error1 == error2
    default:
        return false
    }
}
