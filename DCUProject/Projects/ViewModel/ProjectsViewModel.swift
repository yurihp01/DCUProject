//
//  ProjectsViewModel.swift
//  DCUProject
//
//  Created by PRO on 20/02/2022.
//

import Foundation

protocol ProjectsViewModelProtocol {
    func getProjects() async -> [Project]
}

class ProjectsViewModel {
    private var projects: [Project] = []
    init() {
        print("INIT - ProjectsViewModel ")
    }
    
    deinit {
        print("DEINIT - ProjectsViewModel ")
    }
}

extension ProjectsViewModel: ProjectsViewModelProtocol {
    func getProjects() -> [Project] {
        FirebaseService
    }
}
