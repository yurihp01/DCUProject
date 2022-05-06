//
//  DefinitionViewController.swift
//  DCUProject
//
//  Created by PRO on 01/03/2022.
//

import UIKit

class DefinitionViewController: BaseViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var definitionText: FloatingLabelView!
    
    weak var coordinator: DefinitionCoordinator?
    var viewModel: DefinitionProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setViews()
        definitionText.layer.borderColor = UIColor.gray.cgColor
        definitionText.layer.borderWidth = 0.2
        definitionText.layer.cornerRadius = 4
        definitionText.clipsToBounds = true
    }
    
    @objc func continueButtonPressed() {
        guard let viewModel = viewModel, let text = definitionText.text, !text.isEmpty, !text.contains(viewModel.placeholder) else {
            showAlert(message: "O campo definição está vazio. Preencha e tente novamente!")
            return
        }
        
        viewModel.setDefinition(text) { [weak self] result in
            switch result {
            case .success(let project):
                self?.showMessage(message: "Projeto salvo com sucesso!") { _ in
                    self?.coordinator?.goToHome(project: project)
                }
            case .failure(let error):
                self?.showAlert(message: error.errorDescription)
            }
        }
    }
    
    @IBAction func share(_ sender: UIButton) {
        alertWithTextField(title: "Convidar usuário", message: "Digite o e-mail", placeholder: "email@gmail.com") { message in
            self.viewModel?.project.users.append(message)
            self.showMessage(message: "Enviado com sucesso", handler: nil)
        }
    }
}

private extension DefinitionViewController {
    func setViews() {
        titleLabel.text = Constants.question
    }
    
    func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(continueButtonPressed))
    }
}
