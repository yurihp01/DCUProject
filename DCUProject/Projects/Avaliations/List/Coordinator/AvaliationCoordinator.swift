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
    
    let viewController = AvaliationViewController.instantiate(storyboardName: .main)
    
    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        viewController.viewModel = AvaliationViewModel()
        viewController.coordinator = self
    }
    
    func getViewController() -> AvaliationViewController {
        start()
        return viewController
    }
    
    func goToInsertAvaliation(avaliation: Avaliation?, project: Project) {
        let coordinator = InsertAvaliationCoordinator(navigationController: navigationController, project: project, avaliation: avaliation)
        add(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
}
