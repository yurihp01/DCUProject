//
//  Project.swift
//  DCUProject
//
//  Created by PRO on 20/02/2022.
//

import UIKit

struct Project: Codable {
    var name, date, description, team, category, owner, id: String?
    var analyse: Analyse = Analyse(detail: "", type: .quiz, name: "")
    var users: [String] = []
    var preAvaliation: PreAvaliation = PreAvaliation(screens: [], heuristics: [])
    var avaliations: [Avaliation] = []
    var design: String = ""
    
    init(name: String?, team: String?, category: String?, owner: String?, date: String?, description: String? = nil) {
        self.name = name
        self.team = team
        self.category = category
        self.date = date
        self.description = description
        self.owner = owner
    }
    
    enum CodingKeys: String, CodingKey {
        case name, description, team, category, date, analyse, users, owner, id, preAvaliation, avaliations, design
    }
    
    func getPDF() -> String {
        var text = ""
        
        if let id = id, !id.isEmpty {
            text.append("Id: \(id)\n")
        }
        
        if let description = description, !description.isEmpty {
            text.append("Descrição: \(description)\n")
        }
        
        if let team = team, !team.isEmpty {
            text.append("Time: \(team)\n")
        }
        
        if let category = category, !category.isEmpty {
            text.append("Categoria: \(category)\n")
        }
        
        if let date = date, !date.isEmpty {
            text.append("Data: \(date)\n")
        }
        
        if let owner = owner, !owner.isEmpty {
            text.append("Criador: \(owner)\n")
        }
        
        if !design.isEmpty {
            text.append("Link do Protótipo: \(design)\n")
        }
        
        if !analyse.name.isEmpty {
            text.append("\nAnálise\n\n")
            
            text.append("Título: \(analyse.name)\n")
            text.append("Id: \(analyse.id)\n")
            text.append("Tipo: \(analyse.type)\n")
            
            if analyse.type == "Questionário" {
                for question in analyse.questions {
                    text.append("Questão: \(question.question)\n")
                    text.append("Resposta: \(question.answer)\n")
                }
            } else {
                text.append("Descrição: \(analyse.detail)\n")
            }
        }
        
        if !preAvaliation.heuristics.isEmpty || !preAvaliation.screens.isEmpty {
            text.append("\nPré-Avaliação\n")
            text.append("Id: \(preAvaliation.id)\n")
            
            if !preAvaliation.heuristics.isEmpty {
                text.append("Heurísticas: \(preAvaliation.heuristics.joined(separator: ", "))\n")
            }
            
            if !preAvaliation.screens.isEmpty {
                text.append("Telas: \(preAvaliation.screens.joined(separator: ", "))\n")
            }
        }
        
        if !avaliations.isEmpty {
            text.append("\nAvaliações\n")
            for i in 0...avaliations.count - 1 {
                text.append("Título: \(avaliations[i].title)\n")
                text.append("Id: \(avaliations[i].id)\n")
                text.append("Tela: \(avaliations[i].screen)\n")
                text.append("Heurística: \(avaliations[i].heuristic)\n")
                text.append("Status: \(avaliations[i].status)\n")
                text.append("Avaliador: \(avaliations[i].avaliator)\n")
                text.append("Comentários:\(avaliations[i].comments)\n")
                text.append("Data: \(avaliations[i].date)\n")
            }
        }
        
        if !users.isEmpty {
            text.append("\nConvidados: \(users.joined(separator: ", "))\n")
        }
        
       return text
    }
    
    func toDict() -> NSDictionary {
        let dict = [
            "name":NSString(string: name ?? ""),
            "team":NSString(string: team ?? ""),
            "category":NSString(string: category ?? ""),
            "date":NSString(string: date ?? ""),
            "description":NSString(string: description ?? ""),
            "owner":NSString(string: owner ?? ""),
            "id":NSString(string: id ?? ""),
            "preAvaliation": preAvaliation.toDict(),
            "avaliations":NSArray(array: avaliations.map { $0.toDict() }),
            "users":NSArray(array: users),
            "analyse": analyse.toDict(),
            "design":NSString(string: design)
        ] as [String : Any]
        return NSDictionary(dictionary: dict)
    }
    
    public init(dictionary: Dictionary<String, Any>) throws {
        self = try parseDictionary(with: dictionary, to: Project.self)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        team = try values.decode(String.self, forKey: .team)
        category = try values.decode(String.self, forKey: .category)
        date = try values.decode(String.self, forKey: .date)
        analyse = try values.decode(Analyse.self, forKey: .analyse)
        users = try values.decodeIfPresent([String].self, forKey: .users) ?? []
        owner = try values.decode(String.self, forKey: .owner)
        id = try values.decode(String.self, forKey: .id)
        preAvaliation = try values.decodeIfPresent(PreAvaliation.self, forKey: .preAvaliation) ?? PreAvaliation(screens: [], heuristics: [])
        avaliations = try values.decodeIfPresent([Avaliation].self, forKey: .avaliations) ?? []
        design = try values.decode(String.self, forKey: .design)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(team, forKey: .team)
        try container.encode(category, forKey: .category)
        try container.encode(date, forKey: .date)
        try container.encode(analyse, forKey: .analyse)
        try container.encode(users, forKey: .users)
        try container.encode(owner, forKey: .owner)
        try container.encode(id, forKey: .id)
        try container.encode(preAvaliation, forKey: .preAvaliation)
        try container.encode(avaliations, forKey: .avaliations)
        try container.encode(design, forKey: .design)
    }
    
    static var mockedPreAvaliation: PreAvaliation {
        let preAvaliation = PreAvaliation(screens: ["Tela 1", "Tela 2", "Tela 3", "Tela 4"], heuristics: ["Heurística 1", "Heurística 2", "Heurística 3", "Heurística 4"])
        return preAvaliation
    }
    
    static var mockedAvaliation: [Avaliation] {
        let avaliations = [Avaliation(title: "Avaliacao 1", date: Date().description, screen: "Tela 1", heuristic: "Heurística 1", avaliator: "Yuri", comments: "A tela estava meio ruim", status: Severity.serious.rawValue),
                           Avaliation(title: "Avaliacao 2", date: Date().description, screen: "Tela 2", heuristic: "Heurística 2", avaliator: "Sarah", comments: "A tela estava boa", status: Status.success.description),
                           Avaliation(title: "Avaliacao 3", date: Date().description, screen: "Tela 3", heuristic: "Heurística 3", avaliator: "Sergio", comments: "A tela estava péssima", status: Severity.disaster.rawValue)]
        return avaliations
    }
    
    static var mockedDesign: String {
        "url.first.pt"
    }
    
    static var mockedProject: Project {
        var project = Project(name: "Project 1", team: "Team 1", category: "Category 1", owner: "sarahcampinho@hotmail.com", date: "28/10/2022")
        project.analyse = Analyse.mockedAnalyses
        project.preAvaliation = mockedPreAvaliation
        project.avaliations = mockedAvaliation
        project.design = mockedDesign
        project.description = "The best project in the world!"
        return project
    }
    
    static var mockedProjects = [
        Project(name: "Project 1", team: "Team 1", category: "Category 1", owner: "a@a.com", date: "28/10/2022", description: "Project 1 legal"),
        Project(name: "Project 2", team: "Team 2", category: "Category 2", owner: "a@a.com", date: "28/10/2022", description: "Project 2 legal"),
        Project(name: "Project 3", team: "Team 3", category: "Category 3", owner: "a@a.com", date: "28/10/2022", description: "Project 3 legal"),
        Project(name: "Project 4", team: "Team 4", category: "Category 4", owner: "a@a.com", date: "28/10/2022", description: "Project 4 legal")
    ]
}
