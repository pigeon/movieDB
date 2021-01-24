import Foundation

struct MoviesDTO: Codable, Equatable {
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let movies: [MovieDTO]?

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}
