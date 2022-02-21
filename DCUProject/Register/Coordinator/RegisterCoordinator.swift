//
//  RegisterCoordinator.swift
//  DCUProject
//
//  Created by PRO on 19/02/2022.
//

import Foundation
import UIKit

class RegisterCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = RegisterViewController.instantiate(storyboardName: .main)
        viewController.coordinator = self
        viewController.viewModel = RegisterViewModel()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToProjectsScreen() {
        let coordinator = ProjectsCoordinator(with: navigationController)
        coordinator.parentCoordinator = self
        add(coordinator)
        coordinator.start()
    }
}
