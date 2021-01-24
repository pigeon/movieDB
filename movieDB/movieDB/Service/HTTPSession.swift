import Foundation
// sourcery: AutoMockable
protocol HTTPSession {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

// sourcery: AutoMockable
protocol HTTPSessionDataTask {

}
