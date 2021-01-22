import UIKit

protocol Router {
    func navigateToDetailsList(_ movie: Movie)
}

final class MainRouter: Router {
    private let window: UIWindow
    private var navigationController: UINavigationController?

    init(window: UIWindow = UIWindow(frame: UIScreen.main.bounds)) {
        self.window = window
    }

    func start() {
        let viewModel = MoviesListViewModel(router: self)
        let vc = MoviesListViewController(viewModel: viewModel)
        viewModel.moviesListViewDelegate = vc
        navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func navigateToDetailsList(_ movie: Movie) {
        let viewModel = MovieDetailsViewModel(movie: movie)
        let vc = MovieDetailsViewController(viewModel: viewModel)
        viewModel.movieDetailsViewDelegate = vc
        navigationController?.pushViewController(vc, animated: true)
    }
}
