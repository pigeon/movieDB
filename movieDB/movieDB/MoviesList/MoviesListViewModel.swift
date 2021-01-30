import Foundation
import UIKit

// sourcery: AutoMockable
protocol MoviesListViewDelegate: class {
    func update(with viewState: MoviesListViewState)
}

enum MoviesListViewState {
    case loading
    case content
    case error(String)
}

final class MoviesListViewModel {
    let moviesRepository: MoviesRepository
    let router: Router
    weak var moviesListViewDelegate: MoviesListViewDelegate?
    private var movies = [Movie]()
    private var dataLoading = false

    var numberOfItemsInSection: Int {
        return movies.count
    }

    init(router: Router, moviesRepository: MoviesRepository) {
        self.router = router
        self.moviesRepository = moviesRepository
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification,
                                               object: nil, queue: nil) { [weak self] notification in
            self?.appDidBecomeActive()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func loadData() {
        guard !dataLoading else { return }
        dataLoading = true
        moviesListViewDelegate?.update(with: .loading)
        moviesRepository.movies { [weak self] result in
            self?.dataLoading = false
            switch result {
            case .success(let movies):
                self?.handleContent(movies: movies)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }

    func loadDataIfNeeded(with index: Int) {
        guard index < movies.count && movies.count - index < 2 else {
            return
        }
        loadData()
    }

    func getMovie(with index: Int) -> Movie {
        return movies[index]
    }

    func selectItem(with index: Int) {
        router.navigateToDetailsList(movies[index])
    }

    private func appDidBecomeActive() {
        loadData()
    }

    private func handleContent(movies: [Movie]) {
        self.movies = movies
        moviesListViewDelegate?.update(with: .content)
    }
    private func handleError(error: MoviesServiceError) {
        var errorMessage = "Something went wrong"
        switch error {
        case .badURL:
            errorMessage = "Bad URL"
        case .httpError:
            errorMessage = "Request to MovieDB failed. Try again later"
        case .apiError(let error):
            let nsError = error as NSError
            errorMessage = nsError.localizedDescription
        default:
            break
        }
        moviesListViewDelegate?.update(with: .error(errorMessage))
    }
}
