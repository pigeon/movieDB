import Foundation
@testable import movieDB

class HTTPNetworkSessionMock: HTTPNetworkSession {
    var data: Data?
    var error: Error?
    var urlResponse: URLResponse?

    func loadData(from url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(data, urlResponse, error)
    }
}
