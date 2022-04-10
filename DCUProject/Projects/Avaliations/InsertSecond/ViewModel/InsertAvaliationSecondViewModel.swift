//
//  InsertAvaliationSecondViewModel.swift
//  DCUProject
//
//  Created by PRO on 05/03/2022.
//

import Firebase

protocol InsertAvaliationSecondProtocol {
    var avaliation: Avaliation? { get set }
    func addAvaliation(completion: @escaping (String) -> ())
}

class InsertAvaliationSecondViewModel {
    var avaliation: Avaliation?
    var firebase: FirebaseServiceProtocol
    
    init(avaliation: Avaliation?) {
        self.avaliation = avaliation
        firebase = FirebaseService()
    }
}

extension InsertAvaliationSecondViewModel: InsertAvaliationProtocol {
    func addAvaliation(completion: @escaping (String) -> ()) {
//        add avaliation to firebase
        completion("")
    }
    
}
