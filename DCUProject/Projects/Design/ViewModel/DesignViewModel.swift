//
//  DesignViewModel.swift
//  DCUProject
//
//  Created by PRO on 01/03/2022.
//

import Firebase

protocol DesignViewModelProtocol {
    var project: Project { get }
    func saveImage(image: UIImage)
    func getCurrentUser() -> Firebase.User?
}

class DesignViewModel {
    let firebase: FirebaseServiceProtocol
    var project: Project
    
    init (project: Project) {
        print("INIT: DesignViewModel")
        firebase = FirebaseService()
        self.project = project
    }
    
    deinit {
        print("DEINIT: DesignViewModel")
    }
}

extension DesignViewModel: DesignViewModelProtocol {
    func saveImage(image: UIImage) {
        
    }
    
    func getCurrentUser() -> Firebase.User? {
        return firebase.currentUser
    }
}
