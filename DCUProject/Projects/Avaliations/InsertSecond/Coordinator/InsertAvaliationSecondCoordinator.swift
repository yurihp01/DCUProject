//
//  InsertAvaliationSecondCoordinator.swift
//  DCUProject
//
//  Created by PRO on 05/03/2022.
//

import UIKit

class InsertAvaliationSecondCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    let avaliation: Avaliation?
    let controller = InsertAvaliationSecondViewController.instantiate(storyboardName: .main)
    
    init (navigationController: UINavigationController, avaliation: Avaliation?) {
        self.navigationController = navigationController
        self.avaliation = avaliation
    }
    
    func start() {
        let viewModel = InsertAvaliationSecondViewModel(avaliation: avaliation)
        controller.coordinator = self
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }
}
