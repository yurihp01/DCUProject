//
//  InsertAvaliationViewModel.swift
//  DCUProject
//
//  Created by PRO on 05/03/2022.
//

import Firebase

protocol InsertAvaliationProtocol {
    var avaliation: Avaliation? { get set }
    func addAvaliation(completion: @escaping (String) -> ())
}

class InsertAvaliationViewModel {
    var avaliation: Avaliation?
    var firebase: FirebaseServiceProtocol
    
    init(avaliation: Avaliation?) {
        self.avaliation = avaliation
        firebase = FirebaseService()
    }
}

extension InsertAvaliationViewModel: InsertAvaliationProtocol {
    func addAvaliation(completion: @escaping (String) -> ()) {
//        add avaliation to firebase
        completion("")
    }
    
}
