//
//  AvaliationViewModel.swift
//  DCUProject
//
//  Created by PRO on 06/03/2022.
//

import Foundation

protocol AvaliationProtocol {
    
}

class AvaliationViewModel {
    init (project: Project) {
        print("INIT: AvaliationViewModel")
    }
    
    deinit {
        print("DEINIT: AvaliationViewModel")
    }
}

extension AvaliationViewModel: AvaliationProtocol {
    
}
