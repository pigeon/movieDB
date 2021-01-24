import UIKit

// sourcery: AutoMockable
protocol Router {
    func navigateToDetailsList(_ movie: Movie)
}

final class MainRouter: Router {
    private let window: UIWindow
    private var navigationController: UINavigationController?
    private let moviesRepository: MoviesRepository

    init(window: UIWindow = UIWindow(frame: UIScreen.main.bounds)) {
        self.window = window
        self.moviesRepository = MoviesRepositoryImpl(moviesService: MoviesServiceImpl())
    }

    func start() {
        let viewModel = MoviesListViewModel(router: self, moviesRepository: moviesRepository)
        let vc = MoviesListViewController(viewModel: viewModel)
        viewModel.moviesListViewDelegate = vc
        navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func navigateToDetailsList(_ movie: Movie) {
        let viewModel = MovieDetailsViewModel(movie: movie, moviesRepository: moviesRepository)
        let vc = MovieDetailsViewController(viewModel: viewModel)
        viewModel.movieDetailsViewDelegate = vc
        navigationController?.pushViewController(vc, animated: true)
    }
}
