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
        return [
            Project(name: "Project 1", description: "1", team: "Team 1", category: "Category 1", key: "Key 1", id: "ID 1", date: Date()),
            Project(name: "Project 2", description: "2", team: "Team 2", category: "Category 2", key: "Key 2", id: "ID 2", date: Date()),
            Project(name: "Project 3", description: "3", team: "Team 3", category: "Category 3", key: "Key 3", id: "ID 3", date: Date()),
            Project(name: "Project 4", description: "4", team: "Team 4", category: "Category 4", key: "Key 4", id: "ID 4", date: Date())]
    }
    
    func getProjects(by name: String?) -> [Project] {
        guard let name = name, !name.isEmpty else { return projects }
        return projects.filter({ $0.name.lowercased().contains(name.lowercased())})
    }
    
    func getProjectsCount() -> Int {
        return projects.count
    }
}
