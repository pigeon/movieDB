import Foundation

struct Movie {
    let imageURL: String
    let movieTitle: String
    let movieDescription: String
    let rating: Double
    let releaseDate: String

    init?(url: String?, title: String?, overview: String?, vote: Double?, date: String?) {
        if let url = url,
            let title = title,
            let overview = overview,
            let vote = vote,
            let date = date {
            imageURL = url
            movieTitle = title
            movieDescription = overview
            rating = vote
            releaseDate = date
        } else {
            return nil
        }
    }
}

typealias MoviesPageCompletion = (Result<[Movie], MoviesServiceError>) -> Void


protocol MoviesRepository {
    func movies(completion: @escaping MoviesPageCompletion)
}

final class MoviesRepositoryImpl: MoviesRepository {
    private let moviesService: MoviesService
    private var numberOfPages = 0
    private var currentPage = 0
    private var movies: [Movie] = []

    init(moviesService: MoviesService = MoviesServiceImpl()) {
        self.moviesService = moviesService
    }

    private func movieImageURL(id: String?) -> String? {
        guard let id = id else {
            return nil
        }
        return "https://image.tmdb.org/t/p/w500/\(id)"
    }


    func movies(completion: @escaping MoviesPageCompletion) {
        moviesService.movies(with: currentPage + 1) { [weak self] result in
            guard let self = self else {return}
            switch result {

            case .success(let movies):
                self.currentPage = movies.page ?? self.currentPage
                self.numberOfPages = movies.totalPages ?? self.numberOfPages
                let movies = movies
                    .movies?
                    .map {
                        Movie(url: self.movieImageURL(id: $0.poster_path),
                              title: $0.title,
                              overview: $0.overview,
                              vote: $0.voteAverage,
                              date: $0.releaseDate)
                    }
                    .compactMap { $0 }
                DispatchQueue.main.async {
                    completion(.success(self.handleUpdate(movies: movies)))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    private func handleUpdate(movies: [Movie]?) -> [Movie] {
        guard let movies = movies else {
            return self.movies
        }
        
        if self.movies.isEmpty {
            self.movies = movies
        } else {
            self.movies.append(contentsOf: movies)
        }
        return self.movies
    }
}
