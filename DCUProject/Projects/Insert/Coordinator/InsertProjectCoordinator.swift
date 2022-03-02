//
//  InsertProjectCoordinator.swift
//  DCUProject
//
//  Created by PRO on 01/03/2022.
//

import UIKit

class InsertProjectCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = InsertProjectViewController.instantiate(storyboardName: .main)
        viewController.viewModel = InsertProjectViewModel()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToDefinition(from: DefinitionType, project: Project) {
        let coordinator = DefinitionCoordinator(navigationController, project: project)
        
        if from == .insert {
            coordinator.parentCoordinator = self
            add(coordinator)
        }
        
        coordinator.start()
    }
    
}
