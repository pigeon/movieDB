struct Movie: Equatable, Codable {
    let imageURL: String
    let movieTitle: String
    let movieDescription: String
    let rating: Double
    let releaseDate: String
    let id: String

    init?(url: String?, title: String?, overview: String?, vote: Double?, date: String?, id: Int?) {
        guard let url = url,
            let title = title,
            let overview = overview,
            let vote = vote,
            let date = date,
            let id = id else {
            return nil
        }
            imageURL = url
            movieTitle = title
            movieDescription = overview
            rating = vote
            releaseDate = date
            self.id = String(id)
    }
}
