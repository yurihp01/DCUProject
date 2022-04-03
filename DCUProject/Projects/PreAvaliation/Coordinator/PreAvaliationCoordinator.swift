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
    
    let project: Project
    
    let viewController = PreAvaliationViewController.instantiate(storyboardName: .main)
    
    init(navigationController: UINavigationController, project: Project) {
        self.project = project
        self.navigationController = navigationController
    }
    
    func start() {
        viewController.viewModel = PreAvaliationViewModel(project: project)
        viewController.coordinator = self
    }
    
    func getViewController() -> PreAvaliationViewController {
        start()
        return viewController
    }
}
