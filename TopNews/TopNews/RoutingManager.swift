//
//  RoutingManager.swift
//  TopNews
//
//  Created by Jelena Radojkovic on 10.11.22..
//

import UIKit

class RoutingService {
    private init() {}
    static let shared = RoutingService()
    
    // Setting initial root view controller in navigation stack.
    func setInitialNavigationRoot(_ window: UIWindow) {
        var rootViewController: UINavigationController?
        rootViewController = MainNavigationViewController()
        setInitialViewController(rootViewController)
        window.rootViewController = rootViewController
    }
    
    private func setInitialViewController(_ rootViewController: UINavigationController?) {
        rootViewController?.setViewControllers([getStartingDestination()], animated: false)
    }
    
    private func getStartingDestination() -> UIViewController {
        return MainNewsViewController()
    }
    
    var currentNavigationStackRoot: UINavigationController? {
        return UIApplication.shared.windows.first?.rootViewController as? UINavigationController
    }
}

class MainNavigationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = .white
    }
}
