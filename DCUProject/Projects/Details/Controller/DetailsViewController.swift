//
//  DetailsViewController.swift
//  DCUProject
//
//  Created by PRO on 05/03/2022.
//

import UIKit

enum AvaliationButtonType: String {
    case edit = "Editar"
    case save = "Inserir"
}

enum ButtonType: String {
    case edit = "Editar"
    case save = "Inserir"
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

extension AvaliationButtonType {
    mutating func toggle() {
        switch self {
        case .edit:
            self = .save
        case .save:
            self = .edit
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
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = .darkGray
        label.text = "Detalhes"
        label.font = .systemFont(ofSize: 12)
        label.layer.backgroundColor = UIColor.white.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.frame = CGRect(x: 0, y: 0, width: definition.frame.size.width, height: 14)
        view.addSubview(label)
        return label
    }()
    
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
        label.bottomAnchor.constraint(equalTo: definition.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: definition.leftAnchor).isActive = true
    }
    
    func checkFields() -> Bool {
        if name.text!.isEmpty || name.text == nil {
            showAlert(message: "O campo nome está vazio. Preencha e tente novamente!")
            return false
        }
      
        if team.text!.isEmpty || team.text == nil {
            showAlert(message: "O campo equipe está vazio. Preencha e tente novamente!")
            return false
        }
        
        if category.text!.isEmpty || category.text == nil {
            showAlert(message: "O campo categoria está vazio. Preencha e tente novamente!")
            return false
        }
        
        if definition.text!.isEmpty || definition.text == nil {
            showAlert(message: "O campo detalhes está vazio. Preencha e tente novamente!")
            return false
        }
        
        return true
    }
    
    @IBAction func buttonTouched(_ sender: UIButton) {
        guard checkFields() else { return }
        
        buttonType == .edit ? switchViews() : addFields()
        label.isHidden = stackViewFirst.isHidden
    }
    
    @IBAction func shareButton(_ sender: UIButton) {
        alertWithTextField(title: "Convidar usuário", message: "Digite o e-mail", placeholder: "email@gmail.com") { message in
            self.viewModel?.project.users.append(message)
            self.viewModel?.updateProject(completion: { result in
                switch result {
                case .success:
                    self.showMessage(message: "Convite enviado com sucesso", handler: nil)
                case .failure:
                    self.showMessage(message: "Erro ao enviar convite", handler: nil)
                }
            })
            
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
