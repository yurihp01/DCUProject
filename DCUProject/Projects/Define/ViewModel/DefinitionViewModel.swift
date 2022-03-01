//
//  DefinitionViewModel.swift
//  DCUProject
//
//  Created by PRO on 01/03/2022.
//

import Foundation

protocol DefinitionProtocol {
    var project: Project { get }
    func setDefinition(_ definition: String)
}

class DefinitionViewModel {
    var project: Project
    
    init(project: Project) {
        self.project = project
        print("INIT: DefinitionViewModel")
    }
    
    deinit {
        print("DEINIT: DefinitionViewModel")
    }
}

extension DefinitionViewModel: DefinitionProtocol {
    func setDefinition(_ definition: String) {
        project.description = definition
    }
}
