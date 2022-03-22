//
//  User.swift
//  DCUProject
//
//  Created by PRO on 17/02/2022.
//

import Foundation

struct User: Codable {
    var email: String
    var name, number: String?
    var projects: [Project] = []
    
    init (email: String) {
        self.email = email
    }
    
    enum CodingKeys: String, CodingKey {
        case name, email, number, projects
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        email = try values.decode(String.self, forKey: .email)
        number = try values.decode(String.self, forKey: .number)
        projects = try values.decode([Project].self, forKey: .projects)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(number, forKey: .number)
        try container.encode(projects, forKey: .projects)
    }
    
    func userWithoutDots() -> User {
        let email = self.email.replacingOccurrences(of: ".", with: ",")
        let _ = self.name?.replacingOccurrences(of: ".", with: ",")
        let _ = self.number?.replacingOccurrences(of: ".", with: ",")
        return User(email: email)
    }
}
