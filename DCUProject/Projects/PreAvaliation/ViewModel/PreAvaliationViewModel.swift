//
//  PreAvaliationViewModel.swift
//  DCUProject
//
//  Created by Yuri on 30/03/2022.
//

import Firebase

protocol PreAvaliationViewModelProtocol {
    var preAvaliation: PreAvaliation? { get set }
    func getHeuristics() -> [String]
    func getScreens() -> [String]
    func setHeuristics(_ completion: @escaping (Result<String, FirebaseError>) -> ())
    func setScreens(_ completion: @escaping (Result<String, FirebaseError>) -> ())
    var project: Project { get set }
}

class PreAvaliationViewModel {
    var project: Project
    let firebase: FirebaseServiceProtocol
    var preAvaliation: PreAvaliation?
    
    init(project: Project) {
        self.project = project
        preAvaliation = project.preAvaliation ?? PreAvaliation(screens: [], heuristics: [])
        firebase = FirebaseService()
        print("INIT - PreAvaliationViewModel ")
    }
    
    deinit {
        print("DEINIT - PreAvaliationViewModel ")
    }
}

extension PreAvaliationViewModel: PreAvaliationViewModelProtocol {
    func setHeuristics(_ completion: @escaping (Result<String, FirebaseError>) -> ()) {
        project.preAvaliation = preAvaliation
        firebase.addProject(project: project) { result in
            completion(result)
        }
    }
    
    func setScreens(_ completion: @escaping (Result<String, FirebaseError>) -> ()) {
        project.preAvaliation = preAvaliation
        firebase.addProject(project: project) { result in
            completion(result)
        }
    }
    
    func getHeuristics() -> [String] {
        return Project.mockedProject.preAvaliation?.heuristics ?? []
    }
    
    func getScreens() -> [String] {
        return Project.mockedProject.preAvaliation?.screens ?? []
    }
}
