//
//  AnalyseCoordinator.swift
//  DCUProject
//
//  Created by PRO on 10/03/2022.
//

import UIKit

class AnalyseCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    var project: Project
    
    var analyse: Analyse?
    
    var analyseFlow: AnalyseFlow
    
    init(navigationController: UINavigationController, analyseFlow: AnalyseFlow, project: Project, analyse: Analyse? = nil) {
        self.project = project
        self.navigationController = navigationController
        self.analyseFlow = analyseFlow
        self.analyse = analyse
    }
    
    func start() { }
    
    func start(analyse: Analyse? = nil) {
        let viewController = AnalyseViewController.instantiate(storyboardName: .main)
        viewController.viewModel = AnalyseViewModel(type: analyseFlow, project: project, analyse: analyse)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
        navigationController.isNavigationBarHidden = false
    }
    
    func stop() {
        navigationController.popViewController(animated: true)
    }
}
