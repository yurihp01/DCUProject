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
    func setDefinition(_ definition: String)
    func getCurrentUser() -> Firebase.User?
}

class DefinitionViewModel {
    var project: Project
    let firebase: FirebaseServiceProtocol
    
    init(project: Project) {
        self.project = project
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
    
    func setDefinition(_ definition: String) {
        project.description = definition
        firebase.addProject(project: project)
    }
    
    func getCurrentUser() -> Firebase.User? {
        return firebase.currentUser
    }
}
