//
//  AnalysisViewModelProtocol.swift
//  DCUProject
//
//  Created by PRO on 06/03/2022.
//

import Foundation

protocol AnalysisViewModelProtocol {
    func getAnalysis(by name: String?, and type: String) -> [Analyse]
    var project: Project { get set }
}

class AnalysisViewModel {
    var project: Project
    
    init(project: Project) {
        self.project = project
        print("INIT - AnalysisViewModel ")
    }
    
    deinit {
        print("DEINIT - AnalysisViewModel ")
    }
}

extension AnalysisViewModel: AnalysisViewModelProtocol {
    func getAnalysis(by name: String?, and type: String) -> [Analyse] {
        let analysis = Project.mockedProject.analysis
        guard let name = name, !name.isEmpty else {
            return  analysis.filter({ $0.type.rawValue.elementsEqual(type) })
        }
        return analysis.filter({ $0.name.lowercased().contains(name.lowercased()) && $0.type.rawValue.elementsEqual(type)
        })
    }
}
