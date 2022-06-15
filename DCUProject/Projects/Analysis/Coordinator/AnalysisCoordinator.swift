//
//  AnalysisCoordinator.swift
//  DCUProject
//
//  Created by PRO on 06/03/2022.
//

import UIKit

class AnalysisCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    let delegate: HomeViewDelegate
    let viewController = AnalysisViewController.instantiate(storyboardName: .main)
    
    init (navigationController: UINavigationController, delegate: HomeViewDelegate) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    func start() {
        viewController.viewModel = AnalysisViewModel()
        viewController.coordinator = self
        viewController.homeDelegate = delegate
    }
    
    func getViewController() -> AnalysisViewController {
        start()
        return viewController
    }
}
