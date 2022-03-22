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
    var name: String
    var detail: String
    var type: String = ""
    var analyseType: AnalyseType {
        didSet {
            type = analyseType.rawValue
        }
    }
    
    init(detail: String, type: AnalyseType, name: String) {
        self.name = name
        self.detail = detail
        self.analyseType = type
    }
}

extension Analyse: Codable {
    enum CodingKeys: String, CodingKey {
        case detail, type, name, analyseType
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        detail = try values.decode(String.self, forKey: .detail)
        type = try values.decode(String.self, forKey: .type)
        analyseType = AnalyseType(rawValue: type)!
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(detail, forKey: .detail)
        try container.encode(type, forKey: .type)
    }
    
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
