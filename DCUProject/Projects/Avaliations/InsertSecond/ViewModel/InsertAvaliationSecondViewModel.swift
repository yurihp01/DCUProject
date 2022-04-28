//
//  InsertAvaliationSecondViewModel.swift
//  DCUProject
//
//  Created by PRO on 05/03/2022.
//

import Firebase

protocol InsertAvaliationSecondProtocol {
    var avaliation: Avaliation { get set }
    var project: Project { get set }
    var title: String { get }
    func addAvaliation(completion: @escaping (Result<String, FirebaseError>) -> ())
}

class InsertAvaliationSecondViewModel {
    var avaliation: Avaliation
    var project: Project
    var title: String
    var firebase: FirebaseServiceProtocol
    
    init(avaliation: Avaliation, project: Project, title: String) {
        self.title = title
        self.project = project
        self.avaliation = avaliation
        firebase = FirebaseService()
    }
}

extension InsertAvaliationSecondViewModel: InsertAvaliationSecondProtocol {
    func addAvaliation(completion: @escaping (Result<String, FirebaseError>) -> ()) {
        
        if !title.contains("Editar") {
            project.avaliations.append(avaliation)
        } else if let index = project.avaliations.firstIndex(where: {
            $0.id == avaliation.id
        }) {
            project.avaliations[index] = avaliation
//            usar logica para pegar index e substituir o campo
        }
        
        firebase.updateProject(project: project) { result in
            completion(result)
        }
    }
}
