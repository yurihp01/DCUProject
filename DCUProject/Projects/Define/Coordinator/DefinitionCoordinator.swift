//
//  DefinitionCoordinator.swift
//  DCUProject
//
//  Created by PRO on 01/03/2022.
//

import UIKit

class DefinitionCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    let project: Project
    
    init(_ navigationController: UINavigationController, project: Project) {
        self.navigationController = navigationController
        self.project = project
    }
    
    func start() {
        let viewController = DefinitionViewController.instantiate(storyboardName: .main)
        viewController.viewModel = DefinitionViewModel(project: project)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToHome(project: Project) {
        let coordinator = HomeCoordinator(navigationController: navigationController, project: project)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
}
