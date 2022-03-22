//
//  RegisterViewController.swift
//  DCUProject
//
//  Created by PRO on 19/02/2022.
//

import UIKit

class RegisterViewController: BaseViewController {
    weak var coordinator: RegisterCoordinator?
    var viewModel: RegisterViewModel?
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        indicator.startAnimating()
        Task.init {
            let user = User(email: userField.text ?? "")
            let password = password.text ?? ""
            if let message = await viewModel?.registerUser(with: user.email, password: password),
               message.contains("criado") {
                indicator.stopAnimating()
                showMessage(message: message) {_ in
                    self.coordinator?.goToProjectsScreen()
                }
            } else {
                indicator.stopAnimating()
                showAlert(message: "Email ou senha incorretos. Verifique os campos e tente novamente!")
            }
        }
    }
}
