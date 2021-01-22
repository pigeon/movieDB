import Foundation

struct MovieDetailsViewState {
    let title: String
    let imageURL: String
    let overview: String
    let releaseDate: String
    let rating: String
}

protocol MovieDetailsViewDelegate: class {
    func update(with viewState: MovieDetailsViewState)
}

class MovieDetailsViewModel {
    let movie: Movie
    weak var movieDetailsViewDelegate: MovieDetailsViewDelegate?
    
    init(movie: Movie) {
        self.movie = movie
    }

    func fetchMovieData() {
        let viewState = MovieDetailsViewState(
            title: movie.movieTitle,
            imageURL: movie.imageURL,
            overview: movie.movieDescription,
            releaseDate: movie.releaseDate,
            rating: String(movie.rating))
        movieDetailsViewDelegate?.update(with: viewState)
    }
}
