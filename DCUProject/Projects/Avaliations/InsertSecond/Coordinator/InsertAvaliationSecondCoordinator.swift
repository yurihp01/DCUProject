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
    
    let avaliation: Avaliation
    let title: String
    let project: Project
    let controller = InsertAvaliationSecondViewController.instantiate(storyboardName: .main)
    
    init (navigationController: UINavigationController, project: Project, avaliation: Avaliation, title: String) {
        self.navigationController = navigationController
        self.avaliation = avaliation
        self.title = title
        self.project = project
    }
    
    func start() {
        let viewModel = InsertAvaliationSecondViewModel(avaliation: avaliation, project: project, title: title)
        controller.coordinator = self
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }
}
