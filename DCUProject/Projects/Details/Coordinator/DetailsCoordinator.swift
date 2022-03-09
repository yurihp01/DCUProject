//
//  DetailsCoordinator.swift
//  DCUProject
//
//  Created by PRO on 05/03/2022.
//

import Foundation
import UIKit

class DetailsCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    let project: Project
    let controller = DetailsViewController.instantiate(storyboardName: .main)
    
    init (navigationController: UINavigationController, project: Project) {
        self.navigationController = navigationController
        self.project = project
    }
    
    func start() {
        let viewModel = DetailsViewModel(project: project)
        controller.coordinator = self
        controller.viewModel = viewModel
    }
    
    func getViewController() -> DetailsViewController {
        start()
        return controller
    }
}
