//
//  ProjectsCoordinator.swift
//  DCUProject
//
//  Created by PRO on 20/02/2022.
//

import UIKit

class ProjectsCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    init (with navigationController: UINavigationController) {
        self.navigationController = navigationController
        parentCoordinator = self
    }
    
    func start() {
        let viewController = ProjectsViewController.instantiate(storyboardName: .main)
        viewController.viewModel = ProjectsViewModel()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToCompletedProject(with project: Project) {
        let coordinator = HomeCoordinator(navigationController: navigationController, project: project)
        coordinator.parentCoordinator = self
        add(coordinator)
        coordinator.start()
    }
    
    func goToInsertProject() {
        let coordinator = InsertProjectCoordinator(navigationController: navigationController)
        add(coordinator)
        coordinator.start()
    }
}
