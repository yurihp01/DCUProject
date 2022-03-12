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
    var placeholder: String { get }
    var type: AnalyseFlow { get }
    var buttonType: ButtonType { get set }
}

class AnalyseViewModel {
    var analyse: Analyse?
    var type: AnalyseFlow
    var buttonType: ButtonType
    
    var placeholder: String {
        return Constants.analysePlaceholder
    }
    
    init (type: AnalyseFlow, analyse: Analyse? = nil) {
        self.analyse = analyse
        self.type = type
        buttonType = type == .insert ? .save : .edit
        print("INIT: AnalyseViewModel")
    }
    
    deinit {
        print("DEINIT: AnalyseViewModel")
    }
}

extension AnalyseViewModel: AnalyseProtocol { }
