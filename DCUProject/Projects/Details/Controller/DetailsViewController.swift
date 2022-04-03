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
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var definition: UITextField!
    
    weak var coordinator: DetailsCoordinator?
    var viewModel: DetailsViewModel?
    var buttonType: ButtonType = .edit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields()
        setDatePicker()
        checkOwner()
    }
    
    @IBAction func buttonTouched(_ sender: UIButton) {
        guard
            let name = name.text, !name.isEmpty,
            let team = team.text, !team.isEmpty,
            let category = category.text, !category.isEmpty,
            let definition = definition.text, !definition.isEmpty
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
           !email.elementsEqual("sarahcampinho@hotmail.com") {
            button.isEnabled = false
        }
    }
    
    func setFields() {
        name.text = viewModel?.project.name
        team.text = viewModel?.project.team
        category.text = viewModel?.project.category
        definition.text = viewModel?.project.description
        datePicker.date = viewModel?.project.date ?? Date()
    }
    
    func addFields() {
        if buttonType == .save {
            let project = Project(name: name.text, team: team.text, category: category.text, owner: viewModel?.getCurrentUser()?.email, date: datePicker.date, description: definition.text)
            viewModel?.project = project
            showMessage(message: "Projeto alterado com sucesso!", handler: nil)
        }
    }
    
    func switchViews() {
        buttonType = buttonType == .edit ? .save : .edit
        coordinator?.navigationController.navigationItem.rightBarButtonItem?.title = buttonType.rawValue
        name.isEnabled.toggle()
        team.isEnabled.toggle()
        category.isEnabled.toggle()
        definition.isEnabled.toggle()
        datePicker.isEnabled.toggle()
        button.setTitle(buttonType.rawValue, for: .normal)
    }
    
    func setDatePicker() {
        datePicker.maximumDate = Date()
    }
}
