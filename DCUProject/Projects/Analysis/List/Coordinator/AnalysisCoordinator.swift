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
    
    let project: Project
    let delegate: HomeViewDelegate
    let viewController = AnalysisViewController.instantiate(storyboardName: .main)
    
    init (navigationController: UINavigationController, project: Project, delegate: HomeViewDelegate) {
        self.navigationController = navigationController
        self.project = project
        self.delegate = delegate
    }
    
    func start() {
        viewController.viewModel = AnalysisViewModel(project: project)
        viewController.coordinator = self
        viewController.homeDelegate = delegate
    }
    
    func getViewController() -> AnalysisViewController {
        start()
        return viewController
    }
    
    func goToAnalyseFlow(flow: AnalyseFlow, analyse: Analyse? = nil) {
        let coordinator = AnalyseCoordinator(navigationController: navigationController, analyseFlow: flow, project: project)
        coordinator.parentCoordinator = self
        add(coordinator)
        coordinator.start(analyse: analyse)
    }
}
