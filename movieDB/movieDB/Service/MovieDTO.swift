struct MovieDTO: Codable {
    let vote_count: Int?
    let id: Int?
    let video: Bool?
    let voteAverage: Double?
    let title: String?
    let popularity: Double?
    let poster_path: String?
    let originalLanguage: String?
    let originalTitle: String?
    let genreIds: [Int]?
    let backdropPath: String?
    let adult: Bool?
    let overview: String?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case vote_count
        case id
        case video
        case voteAverage = "vote_average"
        case title
        case popularity
        case poster_path
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult
        case overview
        case releaseDate = "release_date"
    }
}
