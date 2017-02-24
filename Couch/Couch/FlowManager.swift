import UIKit

final class FlowManager {
    
    private var window: UIWindow
    private let viewModel = FlowManagerViewModel()
    private lazy var client: TraktClient = TraktClient()
    private lazy var provider: DataProvider = {
        return DataProvider(client: self.client)
    }()
    
    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window.makeKeyAndVisible()
    }
    
    func showInitialViewController() {
        if viewModel.isLoggedIn() {
            let mainViewController = self.openMovies()
            let navigationController = MainNavigationController(rootViewController: mainViewController)
            self.window.rootViewController = navigationController
        } else {
            let authentication = self.openAuthentication()
            let navigationController = MainNavigationController(rootViewController: authentication)
            self.window.rootViewController = navigationController
        }
    }
    
    private func openAuthentication() -> UIViewController {
        return AuthenticationViewController(provider: self.provider, delegate: self)
    }
    
    private func openMovies() -> UITableViewController {
        return ShowTableViewController(provider: self.provider, delegate: self)
    }
    
    func presentNavigationController() {
        guard let navigationController = self.window.rootViewController as? MainNavigationController else {
            return
        }
        
        let controller = self.openMovies()
        navigationController.viewControllers = [controller]
    }
    
    func presentProfileViewController() {
        guard let navigationController = self.window.rootViewController as? MainNavigationController else {
            return
        }
        let controller = ProfileViewController(provider: self.provider)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func presentDetailsViewController(_ show: Show) {
        guard let navigationController = self.window.rootViewController as? MainNavigationController else {
            return
        }
        let controller = DetailsViewController(provider: self.provider, show: show)
        navigationController.pushViewController(controller, animated: true)
    }
}

extension FlowManager: AuthenticationDelegate {
    func validateWithSuccess() {
        DispatchQueue.main.async(){
            self.presentNavigationController()
        }
    }
}

extension FlowManager: ShowTableViewControllerDelegate {
    func presentProfile() {
        self.presentProfileViewController()
    }
    
    func showTableViewController(_ controller: ShowTableViewController, didSelect show: Show) {
        self.presentDetailsViewController(show)
    }
}
