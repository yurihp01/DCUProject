//
//  AnalysisViewModelProtocol.swift
//  DCUProject
//
//  Created by PRO on 06/03/2022.
//

import Foundation

protocol AnalysisViewModelProtocol {
    func getAnalysis(by name: String?, and type: String) -> [Analyse]
    var project: Project? { get set }
}

class AnalysisViewModel {
    var project: Project? {
        get {
            return FirebaseService.project
        }
        
        set {}
    }
    
    var firebase: FirebaseServiceProtocol
    
    init() {
        self.firebase = FirebaseService()
        print("INIT - AnalysisViewModel ")
    }
    
    deinit {
        print("DEINIT - AnalysisViewModel ")
    } 
}

extension AnalysisViewModel: AnalysisViewModelProtocol {
    func getAnalysis(by name: String?, and type: String) -> [Analyse] {
        let analysis = project?.analysis ?? []
        guard let name = name, !name.isEmpty else {
            return analysis.filter({ $0.analyseType.rawValue.elementsEqual(type) })
        }
        return analysis.filter({ $0.name.lowercased().contains(name.lowercased()) && $0.analyseType.rawValue.elementsEqual(type)
        })
    }
}
