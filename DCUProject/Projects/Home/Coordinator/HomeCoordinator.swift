//
//  HomeCoordinator.swift
//  DCUProject
//
//  Created by PRO on 24/02/2022.
//

import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    let project: Project
    
    init(navigationController: UINavigationController, project: Project) {
        self.project = project
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeViewController.instantiate(storyboardName: .main)
        viewController.viewModel = HomeViewModel(project: project)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
        parentCoordinator = self
        navigationController.viewControllers.removeAll( where: { $0 is InsertProjectViewController || $0 is DefinitionViewController })
//        navigationController.isNavigationBarHidden = true
    }
    
    func changeToDetails() -> DetailsViewController {
        let coordinator = DetailsCoordinator(navigationController: navigationController, project: project)
        coordinator.parentCoordinator = self
        add(coordinator)
        return coordinator.getViewController()
    }
    
    func changeToAnalyse(delegate: HomeViewDelegate) -> AnalysisViewController {
        let coordinator = AnalysisCoordinator(navigationController: navigationController, project: project, delegate: delegate)
        coordinator.parentCoordinator = self
        add(coordinator)
        return coordinator.getViewController()
    }
    
    func changeToAvaliation() -> AvaliationViewController {
        let coordinator = AvaliationCoordinator(navigationController: navigationController, project: project)
        coordinator.parentCoordinator = self
        add(coordinator)
        return coordinator.getViewController()
    }
    
    func changeToPreAvaliation() -> PreAvaliationViewController {
        let coordinator = PreAvaliationCoordinator(navigationController: navigationController, project: project)
        coordinator.parentCoordinator = self
        add(coordinator)
        return coordinator.getViewController()
    }
}
