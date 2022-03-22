//
//  InsertProjectViewModel.swift
//  DCUProject
//
//  Created by PRO on 01/03/2022.
//

import Firebase

protocol InsertProjectProtocol {
    func getCurrentUser() -> Firebase.User?
}

class InsertProjectViewModel: InsertProjectProtocol {
    
    var firebase: FirebaseServiceProtocol
    
    init () {
        print("INIT: InsertProjectViewModel")
        firebase = FirebaseService()
    }
    
    deinit {
        print("DEINIT: InsertProjectViewModel")
    }
    
    func getCurrentUser() -> Firebase.User? {
        return firebase.currentUser
    }
}
