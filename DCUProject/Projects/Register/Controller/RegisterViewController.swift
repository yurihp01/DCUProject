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
    
    override func viewDidDisappear(_ animated: Bool) {
        coordinator?.childDidFinish(coordinator)
        super.viewDidDisappear(animated)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        showLoading(view: view)
        Task.init {
            let email = userField.text ?? ""
            let password = password.text ?? ""
            if let message = await viewModel?.registerUser(with: email, password: password),
               message.contains("criado") {
                stopLoading()
                showMessage(message: message) {_ in
                    self.coordinator?.goToProjectsScreen()
                }
            } else {
                stopLoading()
                showAlert(message: "Email ou senha incorretos. Verifique os campos e tente novamente!")
            }
        }
    }
}
