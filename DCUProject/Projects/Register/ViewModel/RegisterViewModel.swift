//
//  RegisterViewModel.swift
//  DCUProject
//
//  Created by PRO on 19/02/2022.
//

import Foundation

protocol RegisterViewModelProtocol: AnyObject {
    func registerUser(with email: String?, password: String?) async -> String
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
    func registerUser(with email: String?, password: String?) async -> String {
        guard let email = email,
              let password = password else { return "Email ou senha inválidos. Valide os campos e tente novamente!" }
        return await firebaseService.register(email: email, password: password)
    }
}
