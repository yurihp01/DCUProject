//
//  DesignCoordinator.swift
//  DCUProject
//
//  Created by PRO on 17/03/2022.
//

import UIKit

class DesignCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    let viewController = DesignViewController.instantiate(storyboardName: .main)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        viewController.viewModel = DesignViewModel()
        viewController.coordinator = self
    }
    
    func getViewController() -> DesignViewController {
        start()
        return viewController
    }
}
