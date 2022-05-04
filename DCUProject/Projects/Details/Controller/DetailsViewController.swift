//
//  DetailsViewController.swift
//  DCUProject
//
//  Created by PRO on 05/03/2022.
//

import UIKit

enum ButtonType: String {
    case edit = "Editar"
    case save = "Alterar"
    case next = "Continuar"
}

extension ButtonType {
    mutating func toggle() {
        switch self {
        case .edit:
            self = .next
        case .save:
            self = .edit
        case .next:
            self = .save
        }
    }
}

class DetailsViewController: BaseViewController {
    
    @IBOutlet weak var name: FloatingLabelField!
    @IBOutlet weak var team: FloatingLabelField!
    @IBOutlet weak var category: FloatingLabelField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var button: BorderedButton!
    @IBOutlet weak var definition: UITextView!
    @IBOutlet weak var stackViewSecond: UIStackView!
    @IBOutlet weak var stackViewFirst: UIStackView!
    @IBOutlet weak var designButton: BorderedButton!
    
    weak var coordinator: DetailsCoordinator?
    var viewModel: DetailsViewModel?
    var buttonType: ButtonType = .edit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields()
        setDatePicker()
        button.style = .blue
        designButton.style = .white
        definition.layer.borderColor = UIColor.gray.cgColor
        definition.layer.borderWidth = 0.2
        definition.layer.cornerRadius = 4
        definition.clipsToBounds = true
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
        
        buttonType == .edit ? switchViews() : addFields()

    }
    
    @IBAction func shareButton(_ sender: UIButton) {
        alertWithTextField(title: "Convidar usuário", message: "Digite o e-mail", placeholder: "email@gmail.com") { message in
            self.viewModel?.project.users.append(message)
            self.showMessage(message: "Enviado com sucesso", handler: nil)
        }
    }
    
    @IBAction func createDesign(_ sender: UIButton) {
        guard let project = viewModel?.project else { return }
        coordinator?.goToDesign(project: project)
    }
}

private extension DetailsViewController {
    func setFields() {
        name.text = viewModel?.project.name
        team.text = viewModel?.project.team
        category.text = viewModel?.project.category
        definition.text = viewModel?.project.description
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        let date = dateFormat.date(from: viewModel?.project.date ?? "") ?? Date()
        datePicker.date = date
    }
    
    func addFields() {
        if stackViewFirst.isHidden {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd/MM/yyyy"
            viewModel?.project.date = dateFormat.string(from: datePicker.date)
            viewModel?.project.name = name.text
            viewModel?.project.team = team.text
            viewModel?.project.category = category.text
            viewModel?.project.description = definition.text
        
            viewModel?.updateProject(completion: { [weak self] result in
                switch result {
                case .success(let message):
                    self?.showMessage(message: message, handler: nil)
                case .failure(let error):
                    self?.showAlert(message: error.errorDescription)
                }
            })
            
            switchViews()
            stackViewFirst.isHidden.toggle()
            stackViewSecond.isHidden.toggle()
        } else {
            stackViewFirst.isHidden.toggle()
            stackViewSecond.isHidden.toggle()
            buttonType.toggle()
            button.setTitle(buttonType.rawValue, for: .normal)
        }
    }
    
    func switchViews() {
        buttonType.toggle()
        coordinator?.navigationController.navigationItem.rightBarButtonItem?.title = buttonType.rawValue
        name.isEnabled.toggle()
        team.isEnabled.toggle()
        category.isEnabled.toggle()
        definition.isEditable.toggle()
        datePicker.isEnabled.toggle()
        button.setTitle(buttonType.rawValue, for: .normal)
    }
    
    func setDatePicker() {
        datePicker.maximumDate = Date()
    }
}
