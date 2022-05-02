//
//  PreAvaliationCoordinator.swift
//  DCUProject
//
//  Created by Yuri on 30/03/2022.
//

import UIKit

class PreAvaliationCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    let viewController = PreAvaliationViewController.instantiate(storyboardName: .main)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        viewController.viewModel = PreAvaliationViewModel()
        viewController.coordinator = self
    }
    
    func getViewController() -> PreAvaliationViewController {
        start()
        return viewController
    }
}
