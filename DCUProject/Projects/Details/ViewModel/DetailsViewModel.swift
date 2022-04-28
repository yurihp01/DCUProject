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
    func updateProject(completion: @escaping (Result<String, FirebaseError>) -> ())
}

class DetailsViewModel {
    var project: Project
    private var firebase: FirebaseServiceProtocol
    
    init(project: Project) {
        self.project = project
        firebase = FirebaseService()
    }
}

extension DetailsViewModel: DetailsProtocol {
    func updateProject(completion: @escaping (Result<String, FirebaseError>) -> ()) {
        firebase.updateProject(project: project) { result in
            completion(result)
        }
    }
    
    func getCurrentUser() -> Firebase.User? {
        return firebase.currentUser
    }
}
