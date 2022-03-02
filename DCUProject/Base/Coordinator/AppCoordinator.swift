//
//  AppCoordinator.swift
//  DCUProject
//
//  Created by PRO on 16/02/2022.
//

import UIKit

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    init() {
        navigationController = UINavigationController()
    }
    
    func start() {
        let childCoordinator = InsertProjectCoordinator(navigationController: navigationController)
        childCoordinator.parentCoordinator = self
        add(childCoordinator)
        childCoordinator.start()
    }
}
