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



