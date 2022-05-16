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
    var id: String = UUID().uuidString
    var name: String
    var detail: String
    var type: String = ""
    var questions: [Question] = []
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
        case detail, name, analyseType, id, questions
    }
    
    func toDict() -> NSDictionary {
        let dict = [
            "id":NSString(string: id),
            "detail":NSString(string: detail),
            "name":NSString(string: name),
            "analyseType":NSString(string: analyseType.rawValue),
            "questions":NSArray(array: questions),
        ] as [String : Any]
        return NSDictionary(dictionary: dict)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        detail = try values.decode(String.self, forKey: .detail)
        type = try values.decode(String.self, forKey: .analyseType)
        questions = try values.decodeIfPresent([Question].self, forKey: .questions) ?? []
        analyseType = AnalyseType(rawValue: type)!
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(detail, forKey: .detail)
        try container.encode(analyseType.rawValue, forKey: .analyseType)
    }
    
    static let mockedAnalyse = Analyse(detail: "O detalhe é legal ", type: .interview, name: "Análise 1")
    
    static let mockedAnalyses = Analyse(detail: "Entrevista 1 ", type: .interview, name: "Análise 1")
}

struct Question {
    var question: String = ""
    var answer: String = ""
}

extension Question: Codable {
    enum CodingKeys: String, CodingKey {
        case question, answer
    }
    
    func toDict() -> NSDictionary {
        let dict = [
            "question": NSString(string: question),
            "answer":NSString(string: answer)
        ] as [String : Any]
        return NSDictionary(dictionary: dict)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        question = try values.decode(String.self, forKey: .question)
        answer = try values.decode(String.self, forKey: .answer)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(question, forKey: .question)
        try container.encode(answer, forKey: .answer)
    }
}
