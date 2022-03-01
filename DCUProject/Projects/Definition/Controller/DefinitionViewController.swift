//
//  DefinitionViewController.swift
//  DCUProject
//
//  Created by PRO on 01/03/2022.
//

import UIKit

class DefinitionViewController: BaseViewController {

    @IBOutlet weak var definitionText: UITextView!
    @IBOutlet weak var continueButton: UIButton!
    
    weak var coordinator: DefinitionCoordinator?
    var viewModel: DefinitionProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextView()
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        guard let viewModel = viewModel else {
            return
        }

        viewModel.setDefinition(definitionText.text!)
        showMessage(message: "Projeto salvo com sucesso!") { _ in
            self.coordinator?.goToHome(project: viewModel.project)
        }
    }
}

private extension DefinitionViewController {
    func setTextView() {
        definitionText.text = viewModel?.placeholder
        definitionText.textColor = UIColor.lightGray
        definitionText.delegate = self
    }
}

extension DefinitionViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        continueButton.isEnabled = !text.isEmpty && textView.text.count <= 1 ? false : true

        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.textColor = UIColor.black
            textView.text = ""
        }
    }
}
