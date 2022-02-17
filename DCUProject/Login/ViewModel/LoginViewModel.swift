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
}

class LoginViewModel {
    let firebaseService: FirebaseServiceProtocol
    
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
}
