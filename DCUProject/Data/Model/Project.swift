//
//  Project.swift
//  DCUProject
//
//  Created by PRO on 20/02/2022.
//

import Foundation
import UIKit

struct Project {
    private let name, description, team, category, key, id: String
    private let date: Date
    
    init(name: String, description: String, team: String, category: String, key: String, id: String, date: Date) {
        self.name = name
        self.description = description
        self.team = team
        self.category = category
        self.key = key
        self.id = id
        self.date = date
    }
}