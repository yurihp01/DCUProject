//
//  InsertAvaliationViewModel.swift
//  DCUProject
//
//  Created by PRO on 05/03/2022.
//

import Firebase

protocol InsertAvaliationProtocol {
    var avaliation: Avaliation? { get set }
}

class InsertAvaliationViewModel: InsertAvaliationProtocol {
    var avaliation: Avaliation?
    var firebase: FirebaseServiceProtocol
    
    init(avaliation: Avaliation?) {
        self.avaliation = avaliation
        firebase = FirebaseService()
    }
}
