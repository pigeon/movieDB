import Foundation
import EasyStash

protocol Cache {
    func save<T: Codable>(object: T, forKey key: String) throws
    func load<T>(forKey key: String, as: T.Type) throws -> T where T: Decodable, T: Encodable
}

class CacheImpl: Cache {
    let storage: Storage
    init() throws {
        var options = Options()
        options.folder = "Cache"
        storage = try Storage(options: options)
    }
    func save<T>(object: T, forKey key: String) throws where T: Decodable, T: Encodable {
        try storage.save(object: object, forKey: key)
    }

    func load<T>(forKey key: String, as: T.Type) throws -> T where T: Decodable, T: Encodable {
        return try storage.load(forKey: key, as: T.self, withExpiry: .never)
    }
}

