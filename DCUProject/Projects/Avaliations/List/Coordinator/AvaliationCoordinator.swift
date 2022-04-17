//
//  AvaliationCoordinator.swift
//  DCUProject
//
//  Created by PRO on 06/03/2022.
//

import UIKit

class AvaliationCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    let project: Project
    let viewController = AvaliationViewController.instantiate(storyboardName: .main)
    
    init (navigationController: UINavigationController, project: Project) {
        self.navigationController = navigationController
        self.project = project
    }
    
    func start() {
        viewController.viewModel = AvaliationViewModel(project: project)
        viewController.coordinator = self
    }
    
    func getViewController() -> AvaliationViewController {
        start()
        return viewController
    }
    
    func goToInsertAvaliation(avaliation: Avaliation?) {
        let coordinator = InsertAvaliationCoordinator(navigationController: navigationController, project: project, avaliation: avaliation)
        add(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
}
