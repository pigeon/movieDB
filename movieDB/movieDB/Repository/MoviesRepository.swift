import Foundation

typealias MoviesPageCompletion = (Result<[Movie], MoviesServiceError>) -> Void
typealias DetailsCompletion = (Result<MovieDetails, MoviesServiceError>) -> Void

// sourcery: AutoMockable
protocol MoviesRepository {
    func movies(completion: @escaping MoviesPageCompletion)
    func movieDetails(with movieId: String, completion: @escaping DetailsCompletion)
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
                              date: $0.releaseDate,
                              id: $0.id)
                    }
                    .compactMap { $0 }
                DispatchQueue.main.async {
                    completion(.success(self.handleMoviesListUpdate(movies: movies)))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func movieDetails(with movieId: String, completion: @escaping DetailsCompletion) {
        moviesService.movieDetails(with: movieId) { result in
            switch result {
            
            case .success(let movieDetails):
                guard let details = MovieDetails(moviesDeatils: movieDetails) else {
                    DispatchQueue.main.async {
                        completion(.failure(MoviesServiceError.unknown))
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(details))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func handleMoviesListUpdate(movies: [Movie]?) -> [Movie] {
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

private extension MovieDetails {
    init?(moviesDeatils: MovieDetailsDTO) {
        guard let adult = moviesDeatils.adult,
              let budget = moviesDeatils.budget,
              let genres = moviesDeatils.genres,
              let homepage = moviesDeatils.homepage,
              let id = moviesDeatils.id,
              let revenue = moviesDeatils.revenue,
              let tagline = moviesDeatils.tagline,
              let title = moviesDeatils.title else {  return nil }
        
        self.adult = adult
        self.budget = budget
        self.genres =  genres
            .compactMap { $0.name }
            .map { $0 }
        self.homepage = homepage
        self.id = id
        self.revenue = revenue
        self.tagline = tagline
        self.title = title
    }
}
