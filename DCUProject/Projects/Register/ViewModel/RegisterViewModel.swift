//
//  RegisterViewModel.swift
//  DCUProject
//
//  Created by PRO on 19/02/2022.
//

import Foundation

protocol RegisterViewModelProtocol: AnyObject {
    func registerUser(with email: String, password: String) async -> String
}

class RegisterViewModel {
    private let firebaseService: FirebaseServiceProtocol
    
    init() {
        print("INIT: RegisterViewModel ")
        firebaseService = FirebaseService()
    }
    
    deinit {
        print("DEINIT: RegisterViewModel ")
    }
}

extension RegisterViewModel: RegisterViewModelProtocol {
    func registerUser(with email: String, password: String) async -> String {
        if !email.isValidEmail {
            return "Digite um e-mail válido e tente novamente!"
        }
        
        if !password.isValidPassword {
            return "A senha precisa seguir todas as regras. Por favor, tente novamente!"
        }
        
        return await firebaseService.register(email: email, password: password)
    }
}
