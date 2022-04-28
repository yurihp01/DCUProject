//
//  ViewController.swift
//  DCUProject
//
//  Created by PRO on 12/02/2022.
//

import UIKit

class LoginViewController: BaseViewController {
    var viewModel: LoginViewModel?
    weak var coordinator: LoginCoordinator?
    var handle: Handle?
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = viewModel?.handle
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.removeHandle(handle: handle)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        showLoading(view: view)
        Task.init {
            let message = await viewModel?.login(email: userField.text, password: passwordField.text)
            stopLoading()
            if let message = message, message.contains("Logado") {
                showMessage(message: message) {_ in
                    self.coordinator?.goToProjectsScreen()
                }
            } else {
                showAlert(message: message)
            }
        }
    }
    
    @IBAction func RegisterButtonPressed(_ sender: UIButton) {
        coordinator?.goToRegisterScreen()
    }
}

