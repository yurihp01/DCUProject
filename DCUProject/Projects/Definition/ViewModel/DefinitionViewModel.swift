//
//  DefinitionViewModel.swift
//  DCUProject
//
//  Created by PRO on 01/03/2022.
//

import Foundation

protocol DefinitionProtocol {
    var project: Project { get }
    var placeholder: String { get }
    var label: String? { get }
    var type: DefinitionType { get }

    func setDefinition(_ definition: String)
}

class DefinitionViewModel {
    var project: Project
    var type: DefinitionType
    
    init(project: Project, type: DefinitionType) {
        self.project = project
        self.type = type
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
//        firebaseService.addProject()
    }
}
