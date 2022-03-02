//
//  Project.swift
//  DCUProject
//
//  Created by PRO on 20/02/2022.
//

import Foundation
import UIKit

struct Project {
    var name, description, team, category, id: String
    var date: Date
    
    init(name: String, description: String, team: String, category: String, id: String, date: Date) {
        self.name = name
        self.description = description
        self.team = team
        self.category = category
        self.id = id
        self.date = date
    }
    
    static var mockedProject: Project {
        return Project(name: "Project 1", description: "1", team: "Team 1", category: "Category 1", id: "ID 1", date: Date())
    }
}
