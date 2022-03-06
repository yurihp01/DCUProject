//
//  HomeViewController.swift
//  DCUProject
//
//  Created by PRO on 24/02/2022.
//

import UIKit

class HomeViewController: UITabBarController, Storyboarded {

    var viewModel: HomeViewModel?
    weak var coordinator: HomeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTabBarViewControllers()
        addTabBar()
    }
    
    private func addTabBar() {
        let tabBarItems = [
            UITabBarItem(title: "Detalhes", image: UIImage(systemName: "info.circle.fill"), tag: 0),
            UITabBarItem(title: "Análise", image: UIImage(systemName: "rectangle.and.pencil.and.ellipsis"), tag: 1),
//            UITabBarItem(title: "Design", image: UIImage(systemName:"paintpalette.fill"), tag: 2),
            UITabBarItem(title: "Avaliação", image: UIImage(systemName:"checklist"), tag: 3),
            UITabBarItem(title: "Definição", image: UIImage(systemName:""), tag: 4)
        ]
        
        self.delegate = self
        setViewControllers(viewControllers, animated: true)
        tabBarController?.selectedViewController = viewControllers?.first
    }
    
    private func addTabBarViewControllers() {
        guard let coordinator = coordinator else {
            return
        }

        // it still needs to add designVC
        viewControllers = [coordinator.changeToDetails(), coordinator.changeToAnalyse(), coordinator.changeToAvaliation(), coordinator.changeToDefinition()]
    }
}

extension HomeViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarController.selectedViewController = viewController
    }
}
