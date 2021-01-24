@testable import movieDB

extension MovieDetailsDTO {
    static func stub(
        adult: Bool = false,
        backdropPath: String = "backdropPath",
        budget: Int = 10000,
        genres: [Genre] = [],
        homepage: String = "homepage",
        id: Int = 1,
        imdbID: String = "imdbID",
        originalLanguage: String = "",
        originalTitle: String = "originalTitle",
        overview: String = "overview",
        popularity: Double = 1.0,
        posterPath: String = "posterPath",
        releaseDate: String = "",
        revenue: Int = 0,
        runtime: Int = 0,
        status: String = "",
        tagline: String = "",
        title: String = "",
        video: Bool = false,
        voteAverage: Double = 1.0,
        voteCount: Int = 0) -> MovieDetailsDTO {
        return MovieDetailsDTO(
            adult: adult,
            backdropPath: backdropPath,
            budget: budget,
            genres: genres,
            homepage: homepage,
            id: id,
            imdbID: imdbID,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            overview: overview,
            popularity: popularity,
            posterPath: posterPath,
            releaseDate: releaseDate,
            revenue: revenue,
            runtime: runtime,
            status: status,
            tagline: tagline,
            title: title,
            video: video,
            voteAverage: voteAverage,
            voteCount: voteCount)
    }
}
