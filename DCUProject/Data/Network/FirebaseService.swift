//
//  Firebase.swift
//  DCUProject
//
//  Created by PRO on 16/02/2022.
//

import Firebase
import FirebaseDatabase

typealias Handle = AuthStateDidChangeListenerHandle

protocol FirebaseServiceProtocol: AnyObject {
    var handle: Handle { get }
    var ref: DatabaseReference { get set }
    func removeHandle(handle: Handle)
    func login(email: String, password: String) async throws -> String
    func register(email: String, password: String) async -> String
    func getProjects() async -> [Project]
}

class FirebaseService: FirebaseServiceProtocol {
    var handle: Handle {
        return Auth.auth().addStateDidChangeListener { auth, user in }
    }
    
    final var ref: DatabaseReference {
        Database.database().reference(withPath: "")
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
    
    func register(email: String, password: String) async -> String {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            return "Usuário criado com sucesso!"
        } catch {
            return error.localizedDescription
        }
    }
    
    func getProjects() async throws -> [Project] {
        do {
            try await Firestore.collection(<#T##self: Firestore##Firestore#>)
        }
    }
}

private extension FirebaseService {
    func getData() async throws -> Any {
        return await ref.observeSingleEventAndPreviousSiblingKey(of: .value)
    }
}
