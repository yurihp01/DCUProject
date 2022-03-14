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
        switch viewModel?.type {
        case .insert:
            saveDefinition {
                guard let project = viewModel?.project else { return }
                showMessage(message: "Projeto salvo com sucesso!") { _ in
                    self.coordinator?.goToHome(project: project)
                }
            }
        case .home:
            if buttonType == .save {
                saveDefinition {
                    showMessage(message: "Projeto salvo com sucesso!", handler: nil)
                    self.buttonType = .edit
                }
            } else {
                buttonType = .save
            }
            definitionText.isEditable = buttonType == .edit ? false : true
            navigationItem.rightBarButtonItem?.title = buttonType.rawValue
        case .none:
            print("Error")
        }
    }
}

private extension DefinitionViewController {
    func setViews() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.project.name ?? viewModel.label
        definitionText.text =  viewModel.project.description ?? viewModel.placeholder
        definitionText.textColor = definitionText.text.contains(viewModel.placeholder) ? .lightGray : .black
        setTextView()
    }
    
    func setTextView() {
        definitionText.isEditable = viewModel?.type == .insert ? true : false
        definitionText.delegate = self
    }
    
    func setNavigationBar() {
        if let type = viewModel?.type, type != .insert {
            buttonType = .edit
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonType.rawValue, style: .plain, target: self, action: #selector(continueButtonPressed))
    }
    
    func saveDefinition(complete: () -> ()) {
        guard let viewModel = viewModel, let text = definitionText.text, !text.isEmpty, !text.contains(viewModel.placeholder) else {
            showAlert(message: "O campo definição está vazio. Preencha e tente novamente!")
            return
        }

        viewModel.setDefinition(text)
        complete()
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
