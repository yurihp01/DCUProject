//
//  DetailsViewModel.swift
//  DCUProject
//
//  Created by PRO on 05/03/2022.
//

import Firebase

protocol DetailsProtocol {
    var project: Project { get set }
    func getCurrentUser() -> Firebase.User?
}

class DetailsViewModel {
    var project: Project
    var firebase: FirebaseServiceProtocol
    
    init(project: Project) {
        self.project = project
        firebase = FirebaseService()
    }
}

extension DetailsViewModel: DetailsProtocol {
    func getCurrentUser() -> Firebase.User? {
        return firebase.currentUser
    }
}
