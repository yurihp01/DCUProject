//
//  Firebase.swift
//  DCUProject
//
//  Created by PRO on 16/02/2022.
//

import Firebase

typealias Handle = AuthStateDidChangeListenerHandle

protocol FirebaseServiceProtocol: AnyObject {
    var handle: Handle { get }
    func removeHandle(handle: Handle)
    func login(email: String, password: String) async throws -> String
}

class FirebaseService: FirebaseServiceProtocol {
    var handle: Handle {
        return Auth.auth().addStateDidChangeListener { auth, user in }
    }
    
    func removeHandle(handle: Handle) {
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    func login(email: String, password: String) async throws -> String {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            return "Logado com sucesso!"
        } catch {
            return error.localizedDescription
        }
    }
}
