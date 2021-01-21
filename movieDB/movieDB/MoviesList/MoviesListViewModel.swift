protocol MoviesListViewDelegate: class {
    func update(with viewState: MoviesListViewState)
}

enum MoviesListViewState {
    case loading
    case content
    case error
}

final class MoviesListViewModel {
    let moviesRepository: MoviesRepository
    weak var moviesListViewDelegate: MoviesListViewDelegate?
    private var movies = [Movie]()

    var numberOfItemsInSection: Int {
        return movies.count
    }

    init(moviesRepository: MoviesRepository = MoviesRepositoryImpl()) {
        self.moviesRepository = moviesRepository
    }

    func loadData() {
        moviesListViewDelegate?.update(with: .loading)
        moviesRepository.movies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.handleContent(movies: movies)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }

    private func handleContent(movies: [Movie]) {
        self.movies = movies
        moviesListViewDelegate?.update(with: .content)
    }
    private func handleError(error: Error) {
        moviesListViewDelegate?.update(with: .error)
    }

    func getMovie(with index: Int) -> Movie {
        return movies[index]
    }
}
