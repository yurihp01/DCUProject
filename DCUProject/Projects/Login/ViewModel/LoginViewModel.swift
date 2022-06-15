//
//  LoginViewModel.swift
//  DCUProject
//
//  Created by PRO on 16/02/2022.
//

import Firebase

protocol LoginViewModelProtocol {
    var handle: Handle { get }
    func removeHandle(handle: Handle?)
    func login(email: String?, password: String?) async -> String
}

class LoginViewModel {
    private let firebaseService: FirebaseServiceProtocol
    
    init() {
        firebaseService = FirebaseService()
        print("INIT - LoginViewModel")
    }
    
    deinit {
        print("DEINIT - LoginViewModel")
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    var handle: Handle {
        return firebaseService.handle
    }
    
    func removeHandle(handle: Handle?) {
        guard let handle = handle else { return }
        firebaseService.removeHandle(handle: handle)
    }
    
    func login(email: String?, password: String?) async -> String {
        if email != nil, !email!.isValidEmail {
            return "O campo e-mail está inválido. Verifique e tente novamente!"
        }
        
        if password != nil, !password!.isValidPassword {
            return "O campo senha está inválido. Verifique e tente novamente!"
        }
        
        return await firebaseService.login(email: email!, password: password!)
    }
}
