//
//  Avaliation.swift
//  DCUProject
//
//  Created by Yuri on 29/03/2022.
//

import Foundation

enum Status: Codable {
    case success
    case defect(severity: Severity)
    
    var description: String {
        switch self {
        case .success: return "Sucesso"
        case .defect: return "Defeito"
        }
    }
    
    func getStatus(text: String) -> Status {
        switch text {
        case "Sucesso": return Status.success
        case Severity.cosmetic.rawValue:
            return Status.defect(severity: .cosmetic)
        case Severity.lower.rawValue:
            return Status.defect(severity: .lower)
        case Severity.serious.rawValue:
            return Status.defect(severity: .serious)
        case Severity.disaster.rawValue:
            return Status.defect(severity: .disaster)
        default:
            return Status.success
        }
    }
}

enum Severity: String, Codable {
    case cosmetic = "Cosmética"
    case lower = "Menor"
    case serious = "Grave"
    case disaster = "Catastrófico"
}

struct PreAvaliation {
    var screens, heuristics: [String]
}

extension PreAvaliation: Codable {
    enum CodingKeys: String, CodingKey {
        case screens, heuristics
    }
    
    func toDict() -> NSDictionary {
        let dict = [
            "screens":NSArray(array: screens),
            "heuristics":NSArray(array: heuristics)
        ] as [String : Any]
        return NSDictionary(dictionary: dict)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        screens = try values.decode([String].self, forKey: .screens)
        heuristics = try values.decode([String].self, forKey: .heuristics)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(screens, forKey: .screens)
        try container.encode(heuristics, forKey: .heuristics)
    }
}

struct Avaliation {
    var screen, heuristic, avaliator, comments, status: String
    var date: Date
}

extension Avaliation: Codable {
    enum CodingKeys: String, CodingKey {
        case screen, heuristic, avaliator, comments, status, date
    }
    
    func toDict() -> NSDictionary {
        let dict = [
            "screen":NSString(string: screen),
            "heuristic":NSString(string: heuristic),
            "avaliator":NSString(string: avaliator),
            "comments":NSString(string: comments),
            "status":NSString(string: status),
            "date":NSString(string: DateFormatter().string(from: date))
        ] as [String : Any]
        return NSDictionary(dictionary: dict)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        screen = try values.decode(String.self, forKey: .screen)
        heuristic = try values.decode(String.self, forKey: .heuristic)
        avaliator = try values.decode(String.self, forKey: .avaliator)
        comments = try values.decode(String.self, forKey: .comments)
        status = try values.decode(String.self, forKey: .status)
        date = try values.decode(Date.self, forKey: .date)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(screen, forKey: .screen)
        try container.encode(heuristic, forKey: .heuristic)
        try container.encode(comments, forKey: .comments)
        try container.encode(status, forKey: .status)
        try container.encode(date, forKey: .date)
    }
}
