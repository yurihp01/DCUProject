//
//  PreAvaliationViewController.swift
//  DCUProject
//
//  Created by Yuri on 30/03/2022.
//

import UIKit

enum PreAvaliationType: String {
    case heuristic = "Heurísticas"
    case screen = "Telas"
}

protocol PreAvaliationDelegate: AnyObject {
    func getPreAvaliation(with preAvaliation: PreAvaliation)
}

class PreAvaliationViewController: BaseViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: PreAvaliationCoordinator?
    
    var viewModel: PreAvaliationViewModelProtocol?
    var segmentedType = PreAvaliationType.heuristic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func goToInsertPreAvaliation(_ sender: UIButton) {
        if segmentedType == .heuristic {
            var list = viewModel?.getHeuristics() ?? []
            alertWithTextField(title: "Adicionar Heurística", message: "Digite a nova heurística", placeholder: "Heurística") { text in
                list.append(text)
                self.viewModel?.preAvaliation?.heuristics = list
                self.viewModel?.setHeuristics { [weak self] result in
                    switch result {
                    case .success(let message):
                        self?.showMessage(message: message)
                    case .failure(let error):
                        self?.showAlert(message: error.errorDescription)
                    }
                }
            }
        } else {
            var list = viewModel?.getScreens() ?? []
            alertWithTextField(title: "Adicionar Tela", message: "Digite a nova tela", placeholder: "Tela") { text in
                list.append(text)
                self.viewModel?.preAvaliation?.screens = list
                self.viewModel?.setScreens { [weak self] result in
                    switch result {
                    case .success(let message):
                        self?.showMessage(message: message)
                    case .failure(let error):
                        self?.showAlert(message: error.errorDescription)
                    }
                }
            }
        }
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            segmentedType = PreAvaliationType.heuristic
        case 1:
            segmentedType = PreAvaliationType.screen
        default:
            print("Error")
        }
        tableView.reloadData()
    }
    
}

private extension PreAvaliationViewController {
    func setDelegation() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
//  MARK: - VERIFICAR SE O ALTERAR E ADICIONAR NESTA TELA SAO POR MODAL
}

extension PreAvaliationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let list = segmentedType == .heuristic ? viewModel?.getHeuristics() : viewModel?.getScreens(),
              list.count > 0 else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentedType == .heuristic {
            var list = viewModel?.getHeuristics() ?? []
//          remover depois
            self.viewModel?.preAvaliation?.heuristics = list
            alertWithTextField(title: "Alterar Heurística", message: "Digite a nova heurística", placeholder: "Heurística") { text in
                self.viewModel?.preAvaliation?.heuristics[indexPath.row] = text
                self.viewModel?.setHeuristics { [weak self] result in
                    switch result {
                    case .success(let message):
                        self?.showMessage(message: message)
                    case .failure(let error):
                        self?.showAlert(message: error.errorDescription)
                    }
                }
            }
        } else {
            var list = viewModel?.getScreens() ?? []
            alertWithTextField(title: "Alterar Tela", message: "Digite a nova tela", placeholder: "Tela") { text in
                self.viewModel?.preAvaliation?.screens[indexPath.row] = text
                self.viewModel?.setScreens { [weak self] result in
                    switch result {
                    case .success(let message):
                        self?.showMessage(message: message)
                    case .failure(let error):
                        self?.showAlert(message: error.errorDescription)
                    }
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return segmentedType == .heuristic ? viewModel.getHeuristics().count : viewModel.getScreens().count
    }
}
