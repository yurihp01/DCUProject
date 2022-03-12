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
    
    init(name: String?, team: String?, category: String?, date: Date?) {
        self.name = name
        self.team = team
        self.category = category
        self.date = date
    }
    
    init(description: String?) {
        self.description = description
    }
    
    static var mockedProject: Project {
        var project = Project(name: "Project 1", team: "Team 1", category: "Category 1", date: Date())
        project.analysis = Analyse.mockedAnalyses
        project.description = "The best project in the world!"
        return project
    }
}
