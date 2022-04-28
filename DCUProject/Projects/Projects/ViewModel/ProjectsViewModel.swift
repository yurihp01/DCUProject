//
//  ProjectsViewModel.swift
//  DCUProject
//
//  Created by PRO on 20/02/2022.
//

import Foundation

protocol ProjectsViewModelProtocol {
    var projects: [Project] { get set }
    func getProjects(by name: String?) -> [Project]
    func getProjects(_ onCompletion: @escaping () -> ())
}

class ProjectsViewModel {
    var projects: [Project] = []
    let firebase: FirebaseServiceProtocol
    
    init() {
        firebase = FirebaseService()
        print("INIT - ProjectsViewModel ")
    }
    
    deinit {
        print("DEINIT - ProjectsViewModel ")
    }
}

extension ProjectsViewModel: ProjectsViewModelProtocol {
    func getProjects(_ onCompletion: @escaping () -> ()) {
        firebase.getProjects { [weak self] projects in
            guard let self = self else { return }
            self.projects = projects
            onCompletion()
        }
    }
    
    func getProjects(by name: String?) -> [Project] {
        guard let name = name, !name.isEmpty else { return projects }
        return projects.filter({ $0.name!.lowercased().contains(name.lowercased())})
    }
}
