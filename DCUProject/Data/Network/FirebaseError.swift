//
//  FirebaseError.swift
//  DCUProject
//
//  Created by Yuri on 15/04/2022.
//

import Foundation

enum FirebaseError: Error {
    case notFound
    case notUpdated
    case internetConnection
    case notAdded
}

extension FirebaseError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFound:
            return "Não foram encontrados projetos associado a esse usuário"
        case .internetConnection:
            return "Falha ao inserir protótipo. Verifique sua conexão a internet e tente novamente."
        case .notAdded:
            return "Falha ao inserir projeto. Verifique sua conexão a internet e tente novamente."
        case .notUpdated:
            return "Falha ao atualizar projeto. Verifique sua conexão a internet e tente novamente."
        }
    }
}
