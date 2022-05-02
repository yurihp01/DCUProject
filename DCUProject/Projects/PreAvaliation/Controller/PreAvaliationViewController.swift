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
    @IBOutlet weak var button: BorderedButton!
    
    weak var coordinator: PreAvaliationCoordinator?
    
    var viewModel: PreAvaliationViewModelProtocol?
    var segmentedType = PreAvaliationType.heuristic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
        button.style = .blue
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func goToInsertPreAvaliation(_ sender: UIButton) {
        let segment = segmentedType.rawValue.dropLast().description
        alertWithTextField(title: "Adicionar \(segment)", message: "Digite a nova \(segment)", placeholder: segment) { text in
            
            switch self.segmentedType {
            case .heuristic:
                FirebaseService.project?.preAvaliation.heuristics.append(text)
            case .screen:
                FirebaseService.project?.preAvaliation.screens.append(text)
            }
            
            self.viewModel?.setPreAvaliation { [weak self] result in
                switch result {
                case .success(let message):
                    self?.showMessage(message: message, handler: { _ in
                        self?.tableView.reloadData()
                    })
                case .failure(let error):
                    self?.showAlert(message: error.errorDescription)
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
        guard let list = segmentedType == .heuristic ? viewModel?.project?.preAvaliation.heuristics : viewModel?.project?.preAvaliation.screens,
              list.count > 0 else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segment = segmentedType.rawValue.dropLast().description
        alertWithTextField(title: "Alterar \(segment)", message: "Digite a nova \(segment)", placeholder: segment) { text in
            
            switch self.segmentedType {
            case .heuristic:
                FirebaseService.project?.preAvaliation.heuristics[indexPath.row] = text
            case .screen:
                FirebaseService.project?.preAvaliation.screens[indexPath.row] = text
            }
            
            self.viewModel?.setPreAvaliation { [weak self] result in
                switch result {
                case .success(let message):
                    self?.showMessage(message: message) { _ in
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    self?.showAlert(message: error.errorDescription)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let preAvaliation = viewModel?.project?.preAvaliation else { return 0 }
        return segmentedType == .heuristic ? preAvaliation.heuristics.count : preAvaliation.screens.count
    }
}
