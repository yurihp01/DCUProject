//
//  ProjectsViewController.swift
//  DCUProject
//
//  Created by PRO on 20/02/2022.
//

import UIKit

class ProjectsViewController: BaseViewController {
    weak var coordinator: ProjectsCoordinator?
    var viewModel: ProjectsViewModelProtocol?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        setNavigationController()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoading(view: view)
        viewModel?.getProjects {
            self.stopLoading()
            self.tableView.reloadData()
        }
    }
    
    func setNavigationController() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToInsertProject))
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(backToLogin))
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func goToInsertProject() {
        coordinator?.goToInsertProject()
    }
    
    @objc func backToLogin() {
        navigationController?.popToViewController(ofClass: LoginViewController.self)
    }
}

extension ProjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let projects = viewModel?.getProjects(by: searchBar.text),
                projects.count > 0 else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = projects[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let project = viewModel?.getProjects(by: searchBar.text)[indexPath.row] else { return }
        FirebaseService.project = project
        coordinator?.goToCompletedProject(with: project)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getProjects(by: searchBar.text).count ?? 0
    }
}

extension ProjectsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
    }
}
