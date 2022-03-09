//
//  HomeViewController.swift
//  DCUProject
//
//  Created by PRO on 24/02/2022.
//

import UIKit

class HomeViewController: UITabBarController, Storyboarded {

    var viewModel: HomeViewModel?
    weak var coordinator: HomeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTabBarViewControllers()
        addTabBar()
    }
    
    private func addTabBar() {
        self.delegate = self
        setViewControllers(viewControllers, animated: true)
        tabBarController?.selectedViewController = viewControllers?.first
    }
    
    private func addTabBarViewControllers() {
        guard let coordinator = coordinator else {
            return
        }

        // it still needs to add designVC
        viewControllers = [coordinator.changeToDetails(), coordinator.changeToAnalyse(), coordinator.changeToAvaliation(), coordinator.changeToDefinition()].map {
            let navigation = UINavigationController(rootViewController: $0)
            navigation.title = $0.title
            return navigation
        }
    }
}

extension HomeViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarController.selectedViewController = viewController
    }
}
