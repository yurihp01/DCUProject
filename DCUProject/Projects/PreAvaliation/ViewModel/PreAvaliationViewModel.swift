//
//  PreAvaliationViewModel.swift
//  DCUProject
//
//  Created by Yuri on 30/03/2022.
//

import Firebase

protocol PreAvaliationViewModelProtocol {
    func getHeuristics() -> [String]
    func getScreens() -> [String]
    func setHeuristics(heuristics: [String], _ completion: @escaping (String) -> ())
    func setScreens(screens: [String], _ completion: @escaping (String) -> ())
    var project: Project { get set }
}

class PreAvaliationViewModel {
    var project: Project
    let firebase: FirebaseServiceProtocol
    
    init(project: Project) {
        self.project = project
        firebase = FirebaseService()
        print("INIT - PreAvaliationViewModel ")
    }
    
    deinit {
        print("DEINIT - PreAvaliationViewModel ")
    }
}

extension PreAvaliationViewModel: PreAvaliationViewModelProtocol {
    func setHeuristics(heuristics: [String], _ completion: @escaping (String) -> ()) {
        project.preAvaliation?.heuristics = heuristics
        guard let preAvaliation = project.preAvaliation else { return }
        
        firebase.addPreAvaliation(preAvaliation: preAvaliation) { message in
            completion(message)
        }
    }
    
    func setScreens(screens: [String], _ completion: @escaping (String) -> ()) {
        project.preAvaliation?.screens = screens
        guard let preAvaliation = project.preAvaliation else { return }
        firebase.addPreAvaliation(preAvaliation: preAvaliation) { message in
            completion(message)
        }
    }
    
    func getHeuristics() -> [String] {
        return Project.mockedProject.preAvaliation?.heuristics ?? []
    }
    
    func getScreens() -> [String] {
        return Project.mockedProject.preAvaliation?.screens ?? []
    }
}
