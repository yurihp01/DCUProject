//
//  HomeCoordinator.swift
//  DCUProject
//
//  Created by PRO on 24/02/2022.
//

import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    let project: Project
    
    init(navigationController: UINavigationController, project: Project) {
        self.project = project
        self.navigationController = navigationController
        parentCoordinator = self
    }
    
    func start() {
        let viewController = HomeViewController.instantiate(storyboardName: .main)
        viewController.viewModel = HomeViewModel(project: project)
        viewController.coordinator = self
        navigationController.viewControllers.removeAll()
        navigationController.pushViewController(viewController, animated: true)
    }
}
