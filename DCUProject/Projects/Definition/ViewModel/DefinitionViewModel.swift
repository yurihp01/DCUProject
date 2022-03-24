//
//  DefinitionViewModel.swift
//  DCUProject
//
//  Created by PRO on 01/03/2022.
//

import Firebase

protocol DefinitionProtocol {
    var project: Project { get }
    var placeholder: String { get }
    var label: String? { get }
    var type: DefinitionType { get }
    func setDefinition(_ definition: String)
    func getCurrentUser() -> Firebase.User?
}

class DefinitionViewModel {
    var project: Project
    var type: DefinitionType
    let firebase: FirebaseServiceProtocol
    
    init(project: Project, type: DefinitionType) {
        self.project = project
        self.type = type
        firebase = FirebaseService()
        print("INIT: DefinitionViewModel")
    }
    
    deinit {
        print("DEINIT: DefinitionViewModel")
    }
}

extension DefinitionViewModel: DefinitionProtocol {
    var placeholder: String {
        return "Definindo seu tema, já temos um passo realizado! Para que você entenda todo o processo de desenvolvimento de um projeto completo, deixamos aqui um processo completo utilizando a ferramenta! \nBora lá ver?"
    }
    
    var label: String? {
        return type == .home ? project.name : Constants.question
    }
    
    func setDefinition(_ definition: String) {
        project.description = definition
        firebase.addProject(project: project)
    }
    
    func getCurrentUser() -> Firebase.User? {
        return firebase.currentUser
    }
}
