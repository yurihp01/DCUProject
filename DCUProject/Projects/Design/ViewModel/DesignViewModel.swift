//
//  DesignViewModel.swift
//  DCUProject
//
//  Created by PRO on 01/03/2022.
//

import FirebaseStorage
import Firebase

protocol DesignViewModelProtocol {
    var project: Project { get }
    func uploadMedia(image: UIImage, completion: @escaping (Result<String, FirebaseError>) -> ())
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
    func uploadMedia(image: UIImage, completion: @escaping (Result<String, FirebaseError>) -> ()) {
        firebase.addImage(name: "\(project.name?.lowercased() ?? "project").png", image: image, completion: { [weak self] result in
            switch result {
            case .success(let url):
                self?.project.design = url
                self?.addProject(completion: { result in
                    completion(result)
                })
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func addProject(completion: @escaping (Result<String, FirebaseError>) -> ()) {
        firebase.updateProject(project: project) { result in
            completion(result)
        }
    }
    
    func getCurrentUser() -> Firebase.User? {
        return firebase.currentUser
    }
}
