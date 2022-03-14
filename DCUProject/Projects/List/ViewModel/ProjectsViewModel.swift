//
//  ProjectsViewModel.swift
//  DCUProject
//
//  Created by PRO on 20/02/2022.
//

import Foundation

protocol ProjectsViewModelProtocol {
    var projects: [Project] { get set }
    func getProjectsCount() -> Int
    func getProjects(by name: String?) -> [Project]
}

class ProjectsViewModel {
    var projects: [Project] = []
    
    init() {
        Task.init {
            projects = await getProjects()
        }
        
        print("INIT - ProjectsViewModel ")
    }
    
    deinit {
        print("DEINIT - ProjectsViewModel ")
    }
}

extension ProjectsViewModel: ProjectsViewModelProtocol {
    func getProjects() async -> [Project] {
//        FirebaseService
        return Project.mockedProjects
    }
    
    func getProjects(by name: String?) -> [Project] {
        guard let name = name, !name.isEmpty else { return projects }
        return projects.filter({ $0.name!.lowercased().contains(name.lowercased())})
    }
    
    func getProjectsCount() -> Int {
        return projects.count
    }
}
