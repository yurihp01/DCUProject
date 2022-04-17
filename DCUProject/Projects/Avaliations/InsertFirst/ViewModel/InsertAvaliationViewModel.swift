//
//  InsertAvaliationViewModel.swift
//  DCUProject
//
//  Created by PRO on 05/03/2022.
//

import Firebase

protocol InsertAvaliationProtocol {
    var project: Project { get set }
    var avaliation: Avaliation? { get set }
}

class InsertAvaliationViewModel: InsertAvaliationProtocol {
    var project: Project
    var avaliation: Avaliation?
    var firebase: FirebaseServiceProtocol
    
    init(project: Project, avaliation: Avaliation?) {
        self.project = project
        self.avaliation = avaliation
        firebase = FirebaseService()
    }
}
