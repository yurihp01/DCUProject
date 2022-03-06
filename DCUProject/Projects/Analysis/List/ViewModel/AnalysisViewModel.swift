//
//  AnalysisViewModelProtocol.swift
//  DCUProject
//
//  Created by PRO on 06/03/2022.
//

import Foundation

protocol AnalysisViewModelProtocol {
    
}

class AnalysisViewModel {
    let project: Project
    
    init(project: Project) {
        self.project = project
        print("INIT - AnalysisViewModel ")
    }
    
    deinit {
        print("DEINIT - AnalysisViewModel ")
    }
}

extension AnalysisViewModel: AnalysisViewModelProtocol {
    
}
