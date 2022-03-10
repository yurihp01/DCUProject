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
    let type: DefinitionType
    
    lazy var viewController: DefinitionViewController = {
        let viewController = DefinitionViewController.instantiate(storyboardName: .main)
        viewController.viewModel = DefinitionViewModel(project: project, type: type)
        viewController.coordinator = self
        return viewController
    }()
    
    init(_ navigationController: UINavigationController, project: Project, type: DefinitionType) {
        self.navigationController = navigationController
        self.project = project
        self.type = type
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
