@testable import movieDB

extension MovieDTO {
    static func stub(
        vote_count: Int = 500,
        id: Int = 1,
        video: Bool = true,
        voteAverage: Double = 7.0,
        title: String = "title",
        popularity: Double = 1.0,
        poster_path: String = "poster_path",
        originalLanguage: String = "",
        originalTitle: String = "title", genreIds: [Int] = [],
        backdropPath: String = "backdropPath",
        adult: Bool = false,
        overview: String = "",
        releaseDate: String = "") -> MovieDTO {
        return MovieDTO(
            vote_count: vote_count,
            id: id,
            video: video,
            voteAverage: voteAverage,
            title: title,
            popularity: popularity,
            poster_path: poster_path,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            genreIds: genreIds,
            backdropPath: backdropPath,
            adult: adult,
            overview: overview,
            releaseDate: releaseDate)
    }
}
