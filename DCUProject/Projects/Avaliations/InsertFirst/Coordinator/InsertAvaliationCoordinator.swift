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
    let controller = InsertAvaliationViewController.instantiate(storyboardName: .main)
    
    init (navigationController: UINavigationController, avaliation: Avaliation?) {
        self.navigationController = navigationController
        self.avaliation = avaliation
    }
    
    func start() {
        let viewModel = InsertAvaliationViewModel(avaliation: avaliation)
        controller.coordinator = self
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToInsertSecondPart(avaliation: Avaliation?) {
        let coordinator = InsertAvaliationSecondCoordinator(navigationController: navigationController, avaliation: avaliation)
        coordinator.parentCoordinator = self
        add(coordinator)
        coordinator.start()
    }
}
