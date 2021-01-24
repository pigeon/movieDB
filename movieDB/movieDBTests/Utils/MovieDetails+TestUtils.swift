@testable import movieDB

extension MovieDetails {
    static func stub(
        adult: Bool = false,
        budget: Int = 10000,
        genres: [Genre] = [],
        homepage: String = "homepage",
        id: Int = 1,
        revenue: Int = 0,
        tagline: String = "",
        title: String = "") -> MovieDetails {
        return MovieDetails(
            adult: adult,
            budget: budget,
            genres: genres.compactMap { $0.name }.map { $0 },
            homepage: homepage,
            id: id,
            revenue: revenue,
            tagline: tagline,
            title: title)
    }
}
