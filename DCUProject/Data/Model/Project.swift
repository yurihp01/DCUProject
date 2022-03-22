//
//  Project.swift
//  DCUProject
//
//  Created by PRO on 20/02/2022.
//

import UIKit

struct Project: Codable {
    var name, description, team, category, owner, id: String?
    var date: Date?
    var analysis: [Analyse] = []
    var users: [String] = []
    
    init(name: String?, team: String?, category: String?, owner: String?, date: Date?, description: String? = nil) {
        self.name = name
        self.team = team
        self.category = category
        self.date = date
        self.description = description
        self.owner = owner
    }
    
    enum CodingKeys: String, CodingKey {
        case name, description, team, category, date, analysis, users, owner, id
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        team = try values.decode(String.self, forKey: .team)
        category = try values.decode(String.self, forKey: .category)
        date = try values.decode(Date.self, forKey: .date)
        analysis = try values.decode([Analyse].self, forKey: .analysis)
        users = try values.decode([String].self, forKey: .users)
        owner = try values.decode(String.self, forKey: .owner)
        id = try values.decode(String.self, forKey: .id)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(team, forKey: .team)
        try container.encode(category, forKey: .category)
        try container.encode(date, forKey: .date)
        try container.encode(analysis, forKey: .analysis)
        try container.encode(users, forKey: .users)
        try container.encode(owner, forKey: .owner)
        try container.encode(id, forKey: .id)
    }
    
    static var mockedProject: Project {
        var project = Project(name: "Project 1", team: "Team 1", category: "Category 1", owner: "a@a.com", date: Date())
        project.analysis = Analyse.mockedAnalyses
        project.description = "The best project in the world!"
        return project
    }
    
    static var mockedProjects = [
        Project(name: "Project 1", team: "Team 1", category: "Category 1", owner: "a@a.com", date: Date(), description: "Project 1 legal"),
        Project(name: "Project 2", team: "Team 2", category: "Category 2", owner: "a@a.com", date: Date(), description: "Project 2 legal"),
        Project(name: "Project 3", team: "Team 3", category: "Category 3", owner: "a@a.com", date: Date(), description: "Project 3 legal"),
        Project(name: "Project 4", team: "Team 4", category: "Category 4", owner: "a@a.com", date: Date(), description: "Project 4 legal")
    ]
}

struct DictionaryEncoder {
    static func encode<T>(_ value: T) throws -> [String: Any] where T: Encodable {
        let jsonData = try JSONEncoder().encode(value)
        return try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] ?? [:]
    }
}
