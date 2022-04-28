//
//  InsertAvaliationViewController.swift
//  DCUProject
//
//  Created by PRO on 05/03/2022.
//

import iOSDropDown
import UIKit

class InsertAvaliationViewController: BaseViewController {
    
    @IBOutlet weak var screen: DropDown!
    @IBOutlet weak var heuristic: DropDown!
    
    @IBOutlet weak var status: DropDown!
    @IBOutlet weak var severity: DropDown!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var avaliator: UITextField!
    @IBOutlet weak var titleField: UITextField!
    
    weak var coordinator: InsertAvaliationCoordinator?
    var viewModel: InsertAvaliationViewModel?
    var buttonType: ButtonType = .save
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields()
        setDropdowns()
    }
        
    @IBAction func buttonTouched(_ sender: UIButton) {
        if let screen = screen.text, !screen.isEmpty,
           let heuristic = heuristic.text, !heuristic.isEmpty,
           let avaliator = avaliator.text, !avaliator.isEmpty,
           let status = status.text, !status.isEmpty,
           let titleField = titleField.text,
           let title = title,
           let viewModel = viewModel {
            var avaliation = Avaliation(title: titleField, date: Date().description, screen: screen, heuristic: heuristic, avaliator: avaliator, comments: "", status: status)
            avaliation.id = viewModel.avaliation?.id ?? UUID().uuidString
            
            if !severity.isEnabled {
                avaliation.status = status
            } else if let severity = severity.text {
                avaliation.status = severity
            }
            
            coordinator?.goToInsertSecondPart(project: viewModel.project, avaliation: avaliation, title: title)
        } else {
               showAlert(message: "Ainda há campos a serem preenchidos. Verifique e tente novamente!")
               return
        }
    }
}

private extension InsertAvaliationViewController {
    func setDropdowns() {
        guard let project = viewModel?.project else { return }
        screen.optionArray = project.preAvaliation.screens
        heuristic.optionArray = project.preAvaliation.heuristics
        status.optionArray = ["Sucesso", "Defeito"]
        severity.optionArray = [Severity.cosmetic.rawValue, Severity.lower.rawValue, Severity.serious.rawValue, Severity.disaster.rawValue]
        severity.isEnabled = status.text == "Defeito"
        setDropdownSelections()
    }
    
    func setDropdownSelections() {
        status.didSelect{(selectedText , index ,id) in
            self.severity.isEnabled = selectedText == "Defeito"
        }
    }
        
    func setFields() {
        if let avaliation = viewModel?.avaliation {
            buttonType = .edit
            titleField.text = avaliation.title
            screen.text = avaliation.screen
            heuristic.text = avaliation.heuristic
            avaliator.text = avaliation.avaliator
            status.text = avaliation.status == "Sucesso" ? "Sucesso" : "Defeito"
            severity.text = avaliation.status == "Sucesso" ? "Sucesso" : avaliation.status
        }
        title = buttonType.rawValue
    }
}
