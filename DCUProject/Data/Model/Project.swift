//
//  Project.swift
//  DCUProject
//
//  Created by PRO on 20/02/2022.
//

import UIKit

struct Project {
    var name, description, team, category, id: String?
    var date: Date?
    var analysis: [Analyse] = []
    
    init(name: String?, team: String?, category: String?, date: Date?, description: String? = nil) {
        self.name = name
        self.team = team
        self.category = category
        self.date = date
        self.description = description
    }
    
    static var mockedProject: Project {
        var project = Project(name: "Project 1", team: "Team 1", category: "Category 1", date: Date())
        project.analysis = Analyse.mockedAnalyses
        project.description = "The best project in the world!"
        return project
    }
    
    static var mockedProjects = [
        Project(name: "Project 1", team: "Team 1", category: "Category 1", date: Date(), description: "Project 1 legal"),
        Project(name: "Project 2", team: "Team 2", category: "Category 2", date: Date(), description: "Project 2 legal"),
        Project(name: "Project 3", team: "Team 3", category: "Category 3", date: Date(), description: "Project 3 legal"),
        Project(name: "Project 4", team: "Team 4", category: "Category 4", date: Date(), description: "Project 4 legal")
    ]
}
