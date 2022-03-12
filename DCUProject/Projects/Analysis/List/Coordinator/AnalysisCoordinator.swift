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
    let viewController = AnalysisViewController.instantiate(storyboardName: .main)
    
    init (navigationController: UINavigationController, project: Project) {
        self.navigationController = navigationController
        self.project = project
    }
    
    func start() {
        viewController.viewModel = AnalysisViewModel(project: project)
        viewController.coordinator = self
    }
    
    func getViewController() -> AnalysisViewController {
        start()
        return viewController
    }
    
    func goToAnalyseFlow(flow: AnalyseFlow, delegate: AnalysisDelegate, analyse: Analyse? = nil) {
        let coordinator = AnalyseCoordinator(navigationController: navigationController, analyseFlow: flow, delegate: delegate)
        coordinator.parentCoordinator = self
        add(coordinator)
        coordinator.start(analyse: analyse)
    }
}
