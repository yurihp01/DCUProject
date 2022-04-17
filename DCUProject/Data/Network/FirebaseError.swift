//
//  FirebaseError.swift
//  DCUProject
//
//  Created by Yuri on 15/04/2022.
//

import Foundation

enum FirebaseError: Error {
    case notFound
}

extension FirebaseError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFound:
            return "Not found"
        }
    }
}
