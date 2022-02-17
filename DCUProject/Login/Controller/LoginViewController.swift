//
//  ViewController.swift
//  DCUProject
//
//  Created by PRO on 12/02/2022.
//

import UIKit

class LoginViewController: UIViewController, Storyboarded {

    var viewModel: LoginViewModel?
    var coordinator: LoginCoordinator?
    var handle: Handle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = viewModel?.handle
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.removeHandle(handle: handle)
    }


}

