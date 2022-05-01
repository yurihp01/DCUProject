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
    @IBOutlet weak var button: BorderedButton!
    @IBOutlet weak var rulesLabel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.style = .blue
        rulesLabel.layer.borderWidth = 1
        rulesLabel.layer.borderColor = UIColor.black.cgColor
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
            let message = await viewModel?.registerUser(with: email, password: password)
            
            if message != nil, message!.contains("criado") {
                stopLoading()
                showMessage(message: message) {_ in
                    self.coordinator?.goToProjectsScreen()
                }
            } else {
                stopLoading()
                showAlert(message: message)
            }
        }
    }
}
