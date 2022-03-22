//
//  DetailsViewController.swift
//  DCUProject
//
//  Created by PRO on 05/03/2022.
//

import UIKit

enum ButtonType: String {
    case edit = "Editar"
    case save = "Salvar"
}

extension ButtonType {
    mutating func toggle() {
        self = self == .edit ? .save : .edit
    }
}

class DetailsViewController: BaseViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var team: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var coordinator: DetailsCoordinator?
    var viewModel: DetailsViewModel?
    var buttonType: ButtonType = .edit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields()
        setNavigationBar()
        setDatePicker()
        checkOwner()
    }
    
    @objc func buttonTouched() {
        guard
            let name = name.text, !name.isEmpty,
            let team = team.text, !team.isEmpty,
            let category = category.text, !category.isEmpty
        else {
               showAlert(message: "Ainda há campos a serem preenchidos. Verifique e tente novamente!")
               return
        }
        
        addFields()
        switchViews()
    }
}

private extension DetailsViewController {
    func checkOwner() {
        if let email = viewModel?.getCurrentUser()?.email,
           let projectOwner = viewModel?.project.owner,
           !email.elementsEqual(projectOwner) {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonType.rawValue, style: .plain, target: self, action: #selector(buttonTouched))
    }
    
    func setFields() {
        name.text = viewModel?.project.name
        team.text = viewModel?.project.team
        category.text = viewModel?.project.category
        datePicker.date = viewModel?.project.date ?? Date()
    }
    
    func addFields() {
        if buttonType == .save {
            let project = Project(name: name.text, team: team.text, category: category.text, owner: viewModel?.getCurrentUser()?.email, date: datePicker.date)
            viewModel?.project = project
            showMessage(message: "Projeto alterado com sucesso!", handler: nil)
        }
    }
    
    func switchViews() {
        buttonType = buttonType == .edit ? .save : .edit
        navigationItem.rightBarButtonItem?.title = buttonType.rawValue
        name.isEnabled.toggle()
        team.isEnabled.toggle()
        category.isEnabled.toggle()
        datePicker.isEnabled.toggle()
    }
    
    func setDatePicker() {
        datePicker.maximumDate = Date()
    }
}
