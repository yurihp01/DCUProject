//
//  DefinitionCoordinator.swift
//  DCUProject
//
//  Created by PRO on 01/03/2022.
//

import UIKit

enum DefinitionType {
    case insert
    case home
}

class DefinitionCoordinator: Coordinator {
    let project: Project

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    lazy var viewController: DefinitionViewController = {
        let viewController = DefinitionViewController.instantiate(storyboardName: .main)
        viewController.viewModel = DefinitionViewModel(project: project)
        viewController.coordinator = self
        return viewController
    }()
    
    init(_ navigationController: UINavigationController, project: Project) {
        self.navigationController = navigationController
        self.project = project
    }
    
    func start() {
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToHome(project: Project) {
        let coordinator = HomeCoordinator(navigationController: navigationController, project: project)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func getViewController() -> DefinitionViewController {
        return viewController
    }
}
