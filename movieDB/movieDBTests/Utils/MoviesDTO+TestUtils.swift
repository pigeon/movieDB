@testable import movieDB

extension MoviesDTO {
    static func stub(page: Int = 1, totalResults: Int = 100, movies: [MovieDTO] = [] ) -> MoviesDTO {
        return MoviesDTO(page: 3, totalResults: 100, totalPages: 10, movies: movies)
    }
}
