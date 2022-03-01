//
//  DefinitionViewController.swift
//  DCUProject
//
//  Created by PRO on 01/03/2022.
//

import UIKit

class DefinitionViewController: BaseViewController {

    weak var coordinator: DefinitionCoordinator?
    var viewModel: DefinitionProtocol?
    @IBOutlet weak var definitionTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegation()
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        guard let viewModel = viewModel,
              let coordinator = coordinator else {
            return
        }

        viewModel.setDefinition(definitionTextField.text!)
        coordinator.goToHome(project: viewModel.project)
    }
}

private extension DefinitionViewController {
    func setDelegation() {
        definitionTextField.delegate = self
    }
}

extension DefinitionViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        continueButton.isEnabled = textField.text?.isEmpty ?? false
    }
}
