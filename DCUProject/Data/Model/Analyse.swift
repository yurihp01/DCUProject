//
//  Analyse.swift
//  DCUProject
//
//  Created by PRO on 10/03/2022.
//

import Foundation

enum AnalyseType: String {
    case interview = "Entrevista"
    case persona = "Persona"
    case quiz = "Questionário"
}

extension AnalyseType {
    var getTypeId: Int {
        switch self {
        case .interview:
            return 2
        case .persona:
            return 0
        case .quiz:
            return 1
        }
    }
}

struct Analyse {
    var detail: String
    var type: AnalyseType
    var name: String
    
    static let mockedAnalyse = Analyse(detail: "O detalhe é legal ", type: .interview, name: "Análise 1")
    
    static let mockedAnalyses = [
        Analyse(detail: "Entrevista 1 ", type: .interview, name: "Análise 1"),
        Analyse(detail: "Entrevista 2 ", type: .interview, name: "Análise 2"),
        Analyse(detail: "Persona 1 ", type: .persona, name: "Análise 3"),
        Analyse(detail: "Persona 2 ", type: .persona, name: "Análise 4"),
        Analyse(detail: "Questionário 1 ", type: .quiz, name: "Análise 5"),
        Analyse(detail: "Questionário 1 ", type: .quiz, name: "Análise 6")
    ]
}
