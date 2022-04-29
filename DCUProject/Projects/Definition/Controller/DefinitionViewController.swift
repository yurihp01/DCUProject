//
//  DefinitionViewController.swift
//  DCUProject
//
//  Created by PRO on 01/03/2022.
//

import UIKit

class DefinitionViewController: BaseViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var definitionText: UITextView!
    
    weak var coordinator: DefinitionCoordinator?
    var viewModel: DefinitionProtocol?
    var buttonType: ButtonType = .save
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setViews()
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
        alertWithTextField(title: "Convidar", message: "Enviar convite", placeholder: "Digite o e-mail") { message in
            self.viewModel?.project.users.append(message)
            self.showMessage(message: "Enviado com sucesso", handler: nil)
        }
    }
}

private extension DefinitionViewController {
    func setViews() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = Constants.question
        definitionText.text =  viewModel.placeholder
        definitionText.textColor = .lightGray
        setTextView()
    }
    
    func setTextView() {
        definitionText.delegate = self
    }
    
    func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonType.rawValue, style: .plain, target: self, action: #selector(continueButtonPressed))
    }
}

extension DefinitionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.textColor = UIColor.black
            textView.text = ""
        }
    }
}
