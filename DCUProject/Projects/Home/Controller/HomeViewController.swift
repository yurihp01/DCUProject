//
//  HomeViewController.swift
//  DCUProject
//
//  Created by PRO on 24/02/2022.
//

import UIKit

class HomeViewController: BaseViewController {

    var viewModel: HomeViewModel?
    weak var coordinator: HomeCoordinator?
    
    @IBOutlet weak var tabBar: UITabBar!
//    var viewControllers: [UIViewController] = [DetailsVC, AnalyseVC, AvaliationVC, DefinitionViewController]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        tabBar.delegate = self
        tabBar.items = tabBarItems
        tabBar.selectedItem = tabBarItems.first
    }
    
    private func addTabBarViewControllers() {
        
    }
}

extension HomeViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        <#code#>
    }
}
