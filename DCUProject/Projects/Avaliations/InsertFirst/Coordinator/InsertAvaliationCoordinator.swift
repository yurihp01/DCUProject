//
//  InsertAvaliationCoordinator.swift
//  DCUProject
//
//  Created by PRO on 05/03/2022.
//

import UIKit

class InsertAvaliationCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    let avaliation: Avaliation?
    let project: Project
    let controller = InsertAvaliationViewController.instantiate(storyboardName: .main)
    
    init (navigationController: UINavigationController, project: Project, avaliation: Avaliation?) {
        self.navigationController = navigationController
        self.avaliation = avaliation
        self.project = project
    }
    
    func start() {
        let viewModel = InsertAvaliationViewModel(project: project, avaliation: avaliation)
        controller.coordinator = self
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
        navigationController.isNavigationBarHidden = false
    }
    
    func goToInsertSecondPart(project: Project, avaliation: Avaliation, title: String) {
        let coordinator = InsertAvaliationSecondCoordinator(navigationController: navigationController, project: project, avaliation: avaliation, title: title)
        coordinator.parentCoordinator = self
        add(coordinator)
        coordinator.start()
    }
}
