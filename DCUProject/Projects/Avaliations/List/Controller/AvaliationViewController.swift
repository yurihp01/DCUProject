//
//  AvaliationViewController.swift
//  DCUProject
//
//  Created by PRO on 06/03/2022.
//

import UIKit

protocol AvaliationDelegate: AnyObject {
    func getAvaliation(with avaliation: Avaliation)
}

class AvaliationViewController: BaseViewController {
    weak var coordinator: AvaliationCoordinator?
    var viewModel: AvaliationProtocol?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setDelegation()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func setDelegation() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func addAvaliation(_ sender: UIButton) {
        coordinator?.goToInsertAvaliation(avaliation: nil)
    }
}

extension AvaliationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let avaliations = viewModel?.getAvaliations(by: searchBar.text),
              avaliations.count > 0 else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = avaliations[indexPath.row].title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let avaliation = viewModel?.getAvaliations(by: searchBar.text)[indexPath.row] else { return }
        coordinator?.goToInsertAvaliation(avaliation: avaliation)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getAvaliations(by: searchBar.text).count ?? 0
    }
}

extension AvaliationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
    }
}

extension AvaliationViewController: AvaliationDelegate {
    func getAvaliation(with avaliation: Avaliation) {
        viewModel?.project.avaliations.append(avaliation)
    }
}
