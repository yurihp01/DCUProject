//
//  AnalyseViewModel.swift
//  DCUProject
//
//  Created by PRO on 10/03/2022.
//

import Foundation

enum AnalyseFlow {
    case insert
    case edit
}

extension AnalyseFlow {
    mutating func toggle() {
        self = self == .edit ? .insert : .edit
    }
}

protocol AnalyseProtocol {
    var analyse: Analyse? { get set }
    var project: Project { get set }
    var placeholder: String { get }
    var type: AnalyseFlow { get }
    var buttonType: ButtonType { get set }
    
    func addAnalyse(onCompletion: @escaping (Result<String, FirebaseError>) -> ())
}

class AnalyseViewModel {
    var project: Project
    var analyse: Analyse?
    var type: AnalyseFlow
    var buttonType: ButtonType
    
    var placeholder: String {
        return Constants.analysePlaceholder
    }
    
    let firebase: FirebaseServiceProtocol
    
    init (type: AnalyseFlow, project: Project, analyse: Analyse? = nil) {
        self.project = project
        self.analyse = analyse
        self.type = type
        buttonType = type == .insert ? .save : .edit
        firebase = FirebaseService()
        print("INIT: AnalyseViewModel")
    }
    
    deinit {
        print("DEINIT: AnalyseViewModel")
    }
}

extension AnalyseViewModel: AnalyseProtocol {
    func addAnalyse(onCompletion: @escaping (Result<String, FirebaseError>) -> ()) {
        firebase.addProject(project: project, onCompletion: { result in
            return onCompletion(result)
        })
    }
}
