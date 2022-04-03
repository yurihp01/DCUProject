//
//  AvaliationViewModel.swift
//  DCUProject
//
//  Created by PRO on 06/03/2022.
//

import Foundation

protocol AvaliationProtocol {
    var project: Project { get set }
    func getAvaliations(by name: String?) -> [Avaliation]
}

class AvaliationViewModel {
    var project: Project
    
    init (project: Project) {
        self.project = project
        print("INIT: AvaliationViewModel")
    }
    
    deinit {
        print("DEINIT: AvaliationViewModel")
    }
}

extension AvaliationViewModel: AvaliationProtocol {
    func getAvaliations(by name: String?) -> [Avaliation] {
        let avaliations = Project.mockedProject.avaliations
        guard let name = name, !name.isEmpty else { return avaliations }
        return avaliations.filter({ $0.screen.lowercased().contains(name.lowercased())
        })
    }
}
