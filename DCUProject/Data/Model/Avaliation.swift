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

struct PreAvaliation: Codable {
    var screens, heuristics: [String]
}

struct Avaliation: Codable {
    var screen, heuristic, avaliator, comments, status: String
    var date: Date
}
