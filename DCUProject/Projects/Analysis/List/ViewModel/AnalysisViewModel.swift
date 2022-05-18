//
//  AnalysisViewModelProtocol.swift
//  DCUProject
//
//  Created by PRO on 06/03/2022.
//

import Foundation

protocol AnalysisViewModelProtocol {
    var project: Project? { get set }
    func addAnalyse(project: Project?, onCompletion: @escaping (Result<String, FirebaseError>) -> ())
    func getAnalysis(by name: String?) -> [Question]
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
    func getAnalysis(by name: String?) -> [Question] {
        guard let name = name, !name.isEmpty else {
            return project?.analyse?.questions ?? []
        }
        return project?.analyse?.questions.filter({ $0.question.lowercased().contains(name.lowercased())
        }) ?? []
    }
    
    func addAnalyse(project: Project?, onCompletion: @escaping (Result<String, FirebaseError>) -> ()) {
        guard let project = project else { return }
        firebase.updateProject(project: project, onCompletion: { result in
            return onCompletion(result)
        })
    }
}
