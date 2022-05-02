//
//  AvaliationViewModel.swift
//  DCUProject
//
//  Created by PRO on 06/03/2022.
//

import Foundation

protocol AvaliationProtocol {
    var project: Project? { get set }
    func getAvaliations(by name: String?) -> [Avaliation]
}

class AvaliationViewModel {
    var project: Project? {
        get {
            return FirebaseService.project
        }
        
        set {}
    }

    init () {
        self.project = FirebaseService.project
        print("INIT: AvaliationViewModel")
    }
    
    deinit {
        print("DEINIT: AvaliationViewModel")
    }
}

extension AvaliationViewModel: AvaliationProtocol {
    func getAvaliations(by name: String?) -> [Avaliation] {
        guard let project = project,
              let name = name, !name.isEmpty else { return project?.avaliations ?? [] }
        return project.avaliations.filter({ $0.title.lowercased().contains(name.lowercased())})
    }
}
