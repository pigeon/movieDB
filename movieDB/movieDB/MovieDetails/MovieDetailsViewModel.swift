import Foundation

struct MovieDetailsViewState {
    let title: String
    let imageURL: String
    let overview: String
    let releaseDate: String
    let rating: String
    let budget: String

    internal init(
        title: String,
        imageURL: String,
        overview: String,
        releaseDate: String,
        rating: String,
        budget: String = "") {
        self.title = title
        self.imageURL = imageURL
        self.overview = overview
        self.releaseDate = releaseDate
        self.rating = rating
        self.budget = budget
    }
}

protocol MovieDetailsViewDelegate: class {
    func update(with viewState: MovieDetailsViewState)
}

class MovieDetailsViewModel {
    let movie: Movie
    let moviesRepository: MoviesRepository
    weak var movieDetailsViewDelegate: MovieDetailsViewDelegate?
    
    init(movie: Movie, moviesRepository: MoviesRepository) {
        self.movie = movie
        self.moviesRepository = moviesRepository
    }

    func fetchMovieData() {
        let viewState = MovieDetailsViewState(
            title: movie.movieTitle,
            imageURL: movie.imageURL,
            overview: movie.movieDescription,
            releaseDate: movie.releaseDate,
            rating: String(movie.rating))
        movieDetailsViewDelegate?.update(with: viewState)
        moviesRepository.movieDetails(with: movie.id) { [weak self] result in
            switch result {
            case .success(let movieDetails):
                self?.handleMoviesDetails(movieDetails)
            case .failure:
                // we silent error here because we have initial data to populate the screen
                break
            }
        }
    }

    private func handleMoviesDetails(_ movieDetails: MovieDetails) {
        let viewState = MovieDetailsViewState(
            title: movie.movieTitle,
            imageURL: movie.imageURL,
            overview: movie.movieDescription,
            releaseDate: movie.releaseDate,
            rating: String(movie.rating) ,
            budget: String(movieDetails.budget))
        movieDetailsViewDelegate?.update(with: viewState)
    }
}
