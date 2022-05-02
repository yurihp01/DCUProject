//
//  HomeViewController.swift
//  DCUProject
//
//  Created by PRO on 24/02/2022.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func showMoreOption(items: [UIBarButtonItem])
}

class HomeViewController: UITabBarController, Storyboarded {

    var viewModel: HomeViewModel?
    weak var coordinator: HomeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTabBar()
    }
    
    private func addTabBar() {
        guard let coordinator = coordinator else { return }
        self.delegate = self
        viewControllers = [coordinator.changeToDetails(),coordinator.changeToAnalyse(delegate: self), coordinator.changeToPreAvaliation(), coordinator.changeToAvaliation()]
        setViewControllers(viewControllers, animated: true)
        tabBarController?.selectedViewController = viewControllers?.first
        navigationItem.title = viewControllers?.first?.title
    }
}

extension HomeViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarController.selectedViewController = viewController
        navigationItem.title = viewController.title
        self.tabBarController?.navigationItem.rightBarButtonItems = []
    }
}

extension HomeViewController: HomeViewDelegate {
    func showMoreOption(items: [UIBarButtonItem]) {
        self.tabBarController?.navigationItem.rightBarButtonItems = items
    }
}
