//
//  HomeViewModel.swift
//  DCUProject
//
//  Created by PRO on 24/02/2022.
//

import Foundation

class HomeViewModel {
    let project: Project
    
    init(project: Project) {
        self.project = project
        
        print("INIT: HomeViewModel")
    }
    
    deinit {
        print("DEINIT: HomeViewModel")
    }
}
