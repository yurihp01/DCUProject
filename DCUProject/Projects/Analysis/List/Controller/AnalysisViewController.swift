//
//  AnalysisViewController.swift
//  DCUProject
//
//  Created by PRO on 06/03/2022.
//

import UIKit

class AnalysisViewController: BaseViewController {
    weak var coordinator: AnalysisCoordinator?
    var viewModel: AnalysisViewModelProtocol?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var analyseSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
}

extension AnalysisViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let projects = viewModel?.getProjects(by: searchBar.text),
//                projects.count > 0 else {  }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = projects[indexPath.row].name
//        return cell
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let project = viewModel?.getProjects(by: searchBar.text)[indexPath.row] else { return }
//        coordinator?.goToCompletedProject(with: project)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}

extension AnalysisViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
    }
}
