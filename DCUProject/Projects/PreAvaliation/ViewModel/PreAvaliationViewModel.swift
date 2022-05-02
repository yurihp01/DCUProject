//
//  PreAvaliationViewModel.swift
//  DCUProject
//
//  Created by Yuri on 30/03/2022.
//

import Firebase

protocol PreAvaliationViewModelProtocol {
    func setPreAvaliation(_ completion: @escaping (Result<String, FirebaseError>) -> ())
    var project: Project? { get set }
}

class PreAvaliationViewModel {
    var project: Project? {
        get {
            return FirebaseService.project
        }
        
        set {}
    }
    
    let firebase: FirebaseServiceProtocol
    var preAvaliation: PreAvaliation?
    
    init() {
        firebase = FirebaseService()
        print("INIT - PreAvaliationViewModel ")
    }
    
    deinit {
        print("DEINIT - PreAvaliationViewModel ")
    }
}

extension PreAvaliationViewModel: PreAvaliationViewModelProtocol {
    func setPreAvaliation(_ completion: @escaping (Result<String, FirebaseError>) -> ()) {
        guard let project = project else { return }
        firebase.updateProject(project: project) { result in
            completion(result)
        }
    }
}
