import Foundation
@testable import movieDB


class CacheMock: Cache {
    var saveObjectWasCalled: Bool = false
    var loadObjectWasCalled: Bool = false
    var saveReturnValue: Codable!

    func save<T>(object: T, forKey key: String) throws where T : Decodable, T : Encodable {
        saveObjectWasCalled = true
    }
    func load<T>(forKey key: String, as: T.Type) throws -> T where T : Decodable, T : Encodable {
        loadObjectWasCalled = true
        return saveReturnValue as! T
    }
}
