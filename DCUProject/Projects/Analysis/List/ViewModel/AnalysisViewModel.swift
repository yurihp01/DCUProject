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
    var firebase: FirebaseServiceProtocol
    
    init(project: Project) {
        self.project = project
        self.firebase = FirebaseService()
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
            return  analysis.filter({ $0.analyseType.rawValue.elementsEqual(type) })
        }
        return analysis.filter({ $0.name.lowercased().contains(name.lowercased()) && $0.analyseType.rawValue.elementsEqual(type)
        })
    }
    
    func getProject() -> Project {
        return firebase.project ?? Project.mockedProject
    }
}
