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
    
    let project: Project
    
    init(navigationController: UINavigationController, project: Project) {
        self.navigationController = navigationController
        self.project = project
    }
    
    func start() {
        viewController.viewModel = DesignViewModel(project: project)
        viewController.coordinator = self
    }
    
    func getViewController() -> DesignViewController {
        start()
        return viewController
    }
}
