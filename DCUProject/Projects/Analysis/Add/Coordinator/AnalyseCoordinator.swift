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
    
    var delegate: AnalysisDelegate
    
    var analyseFlow: AnalyseFlow
    
    init(navigationController: UINavigationController, analyseFlow: AnalyseFlow, delegate: AnalysisDelegate, analyse: Analyse? = nil) {
        self.navigationController = navigationController
        self.analyseFlow = analyseFlow
        self.delegate = delegate
    }
    
    func start() { }
    
    func start(analyse: Analyse? = nil) {
        let viewController = AnalyseViewController.instantiate(storyboardName: .main)
        viewController.viewModel = AnalyseViewModel(type: analyseFlow, analyse: analyse)
        viewController.coordinator = self
        viewController.delegate = delegate
        navigationController.pushViewController(viewController, animated: true)
        navigationController.isNavigationBarHidden = false
    }
    
//    func stop() {
//        navigationController.popViewController(animated: true)
//    }
}
