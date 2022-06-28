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
}

enum Severity: String, Codable {
    case cosmetic = "Cosmética"
    case lower = "Menor"
    case serious = "Grave"
    case disaster = "Catastrófico"
}

struct PreAvaliation {
    var id: String = UUID().uuidString
    var screens: [String] = []
    var heuristics: [String] = []
}

extension PreAvaliation: Codable {
    enum CodingKeys: String, CodingKey {
        case screens, heuristics, id
    }
    
    func toDict() -> NSDictionary {
        let dict = [
            "id": NSString(string: id),
            "screens":NSArray(array: screens),
            "heuristics":NSArray(array: heuristics)
        ] as [String : Any]
        return NSDictionary(dictionary: dict)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        screens = try values.decodeIfPresent([String].self, forKey: .screens) ?? []
        heuristics = try values.decodeIfPresent([String].self, forKey: .heuristics) ?? []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(screens, forKey: .screens)
        try container.encode(heuristics, forKey: .heuristics)
    }
}

struct Avaliation {
    var title, date, screen, heuristic, avaliator, comments, status: String
    var id: String = UUID().uuidString
}

extension Avaliation: Codable {
    enum CodingKeys: String, CodingKey {
        case screen, heuristic, avaliator, comments, status, date, title, id
    }
    
    func toDict() -> NSDictionary {
        let dict = [
            "id":NSString(string: id),
            "title":NSString(string: title),
            "screen":NSString(string: screen),
            "heuristic":NSString(string: heuristic),
            "avaliator":NSString(string: avaliator),
            "comments":NSString(string: comments),
            "status":NSString(string: status),
            "date":NSString(string: date)
        ] as [String : Any]
        return NSDictionary(dictionary: dict)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        screen = try values.decode(String.self, forKey: .screen)
        heuristic = try values.decode(String.self, forKey: .heuristic)
        avaliator = try values.decode(String.self, forKey: .avaliator)
        comments = try values.decode(String.self, forKey: .comments)
        status = try values.decode(String.self, forKey: .status)
        date = try values.decode(String.self, forKey: .date)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(screen, forKey: .screen)
        try container.encode(heuristic, forKey: .heuristic)
        try container.encode(comments, forKey: .comments)
        try container.encode(status, forKey: .status)
        try container.encode(date, forKey: .date)
    }
}
