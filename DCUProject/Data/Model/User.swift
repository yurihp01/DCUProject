//
//  User.swift
//  DCUProject
//
//  Created by PRO on 17/02/2022.
//

import Foundation

struct User: Codable {
    let name, email, number: String
    
    init(name: String, email: String, number: String) {
        self.name = name
        self.email = email
        self.number = number
    }
}
