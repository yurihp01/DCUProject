//
//  AnalysisViewController.swift
//  DCUProject
//
//  Created by PRO on 06/03/2022.
//

import UIKit

class AnalysisViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var analyseSegmentedControl: UISegmentedControl!
    
    weak var coordinator: AnalysisCoordinator?
    var viewModel: AnalysisViewModelProtocol?
    var type: String = AnalyseType.persona.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
        setNavigationController()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func goToInsertAnalyse() {
        coordinator?.goToAnalyseFlow(flow: .insert)
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            type = AnalyseType.persona.rawValue
        case 1:
            type = AnalyseType.quiz.rawValue
        case 2:
            type = AnalyseType.interview.rawValue
        default:
            print("Error")
        }
        tableView.reloadData()
    }
    
    @IBAction func createDesign(_ sender: UIButton) {
        guard let project = viewModel?.project else { return }
        coordinator?.goToDesign(project: project)
    }
    
}

private extension AnalysisViewController {
    func setDelegation() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setNavigationController() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToInsertAnalyse))
        navigationItem.rightBarButtonItem = button
    }
}

extension AnalysisViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let analyses = viewModel?.getAnalysis(by: searchBar.text, and: type),
              analyses.count > 0 else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = analyses[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let analyse = viewModel?.getAnalysis(by: searchBar.text, and: type)[indexPath.row] else { return }
        coordinator?.goToAnalyseFlow(flow: .edit, analyse: analyse)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getAnalysis(by: searchBar.text, and: type).count ?? 0
    }
}

extension AnalysisViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
    }
}
