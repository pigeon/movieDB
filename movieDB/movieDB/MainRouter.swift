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
        let viewController = MoviesListViewController(viewModel: viewModel)
        viewModel.moviesListViewDelegate = viewController
        navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func navigateToDetailsList(_ movie: Movie) {
        let viewModel = MovieDetailsViewModel(movie: movie, moviesRepository: moviesRepository)
        let viewController = MovieDetailsViewController(viewModel: viewModel)
        viewModel.movieDetailsViewDelegate = viewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}
