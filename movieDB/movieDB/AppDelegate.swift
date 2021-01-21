//
//  AppDelegate.swift
//  movieDB
//
//  Created by Dmytro Golub on 21/01/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var mainRouter: MainRouter!

    func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        mainRouter = MainRouter()
        return true
    }
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        mainRouter.start()
        return true
    }
}

final class MainRouter {
    private let window: UIWindow

    init(window: UIWindow = UIWindow(frame: UIScreen.main.bounds)) {
        self.window = window
    }

    func start() {
        let viewModel = MoviesListViewModel()
        let vc = MoviesListViewController(viewModel: viewModel)
        viewModel.moviesListViewDelegate = vc
        window.rootViewController = UINavigationController(rootViewController: vc)
        window.makeKeyAndVisible()
    }

}
