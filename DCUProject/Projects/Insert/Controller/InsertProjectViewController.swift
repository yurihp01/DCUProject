//
//  InsertProjectViewController.swift
//  DCUProject
//
//  Created by PRO on 01/03/2022.
//

import UIKit

class InsertProjectViewController: BaseViewController {

    @IBOutlet weak var name: FloatingLabelField!
    @IBOutlet weak var team: FloatingLabelField!
    @IBOutlet weak var category: FloatingLabelField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var createButton: BorderedButton!
    
    weak var coordinator: InsertProjectCoordinator?
    var viewModel: InsertProjectProtocol?
    var project: Project?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePicker()
        createButton.style = .blue
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        guard let email = viewModel?.getCurrentUser()?.email, checkFields() else {
               return
           }
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"

        project = Project(name: name.text!, team: team.text!, category: category.text!, owner: email, date: dateFormat.string(from: datePicker.date))
        coordinator?.goToDefinition(from: .insert, project: project!)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        datePicker.date = sender.date
    }
}

private extension InsertProjectViewController {
    func setDatePicker() {
        datePicker.maximumDate = Date()
    }
    
    func checkFields() -> Bool {
        if name.text!.isEmpty || name.text == nil {
            showAlert(message: "O campo título está vazio. Preencha e tente novamente!")
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
        
        return true
    }
}
