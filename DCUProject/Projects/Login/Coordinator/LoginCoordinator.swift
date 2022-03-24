//
//  LoginCoordinator.swift
//  DCUProject
//
//  Created by PRO on 16/02/2022.
//

import UIKit

class LoginCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = LoginViewController.instantiate(storyboardName: .main)
        viewController.viewModel = LoginViewModel()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
 
    func goToRegisterScreen() {
        let childCoordinator = RegisterCoordinator(navigationController: navigationController)
        childCoordinator.parentCoordinator = self
        add(childCoordinator)
        childCoordinator.start()
    }
    
    func goToProjectsScreen() {
        let coordinator = ProjectsCoordinator(with: navigationController)
        coordinator.start()
    }
}
