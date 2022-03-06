//
//  DetailsViewModel.swift
//  DCUProject
//
//  Created by PRO on 05/03/2022.
//

import Foundation

protocol DetailsProtocol {
    var project: Project { get set }
}

class DetailsViewModel {
    var project: Project
    
    init(project: Project) {
        self.project = project
    }
}

extension DetailsViewModel: DetailsProtocol {

}
