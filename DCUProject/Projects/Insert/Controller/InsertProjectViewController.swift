//
//  InsertProjectViewController.swift
//  DCUProject
//
//  Created by PRO on 01/03/2022.
//

import UIKit

class InsertProjectViewController: BaseViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var team: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var createButton: UIButton!
    
    weak var coordinator: InsertProjectCoordinator?
    var viewModel: InsertProjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePicker()
    }

    @IBAction func createButtonPressed(_ sender: UIButton) {
        guard let name = name.text, !name.isEmpty,
           let team = team.text, !team.isEmpty,
           let category = category.text, !category.isEmpty else {
               showAlert(message: "Ainda há campos a serem preenchidos. Verifique e tente novamente!")
               return
           }
        let project = Project(name: name, description: "", team: team, category: category, id: "", date: datePicker.date)
        coordinator?.goToDefinition(from: .insert, project: project)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        datePicker.date = sender.date
        
    }
}

private extension InsertProjectViewController {
    func setDatePicker() {
        datePicker.maximumDate = Date()
    }
}
