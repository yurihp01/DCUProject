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
}

class FirebaseService { }

extension FirebaseService: FirebaseServiceProtocol {
    var handle: Handle {
        return Auth.auth().addStateDidChangeListener { auth, user in }
    }
    
    func removeHandle(handle: Handle) {
        Auth.auth().removeStateDidChangeListener(handle)
    }
}
