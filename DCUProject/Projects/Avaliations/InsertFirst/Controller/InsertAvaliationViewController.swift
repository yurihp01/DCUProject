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
    @IBOutlet weak var avaliator: UITextField!
    @IBOutlet weak var status: DropDown!
    @IBOutlet weak var severity: DropDown!
    @IBOutlet weak var button: UIButton!
    
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
                  let status = status.text, !status.isEmpty {
            if !severity.isEnabled {
                viewModel?.avaliation = Avaliation(screen: screen, heuristic: heuristic, avaliator: avaliator, comments: "", status: status, date: Date())
            } else if let severity = severity.text {
                viewModel?.avaliation = Avaliation(screen: screen, heuristic: heuristic, avaliator: avaliator, comments: "", status: severity, date: Date())
            }
        } else {
               showAlert(message: "Ainda há campos a serem preenchidos. Verifique e tente novamente!")
               return
        }
        coordinator?.goToInsertSecondPart(avaliation: viewModel?.avaliation)
    }
}

private extension InsertAvaliationViewController {
    func setDropdowns() {
        guard let viewModel = viewModel else { return }
            let project = viewModel.firebase.project
        screen.optionArray = project?.preAvaliation?.screens ?? []
        heuristic.optionArray = project?.preAvaliation?.heuristics ?? []
        status.optionArray = ["Sucesso", "Defeito"]
        severity.optionArray = [Severity.cosmetic.rawValue, Severity.lower.rawValue, Severity.serious.rawValue, Severity.disaster.rawValue]
        severity.isEnabled = false
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
            screen.text = avaliation.screen
            heuristic.text = avaliation.heuristic
            avaliator.text = avaliation.avaliator
            status.text = avaliation.status == "Sucesso" ? "Sucesso" : "Defeito"
            severity.text = avaliation.status == "Sucesso" ? "Sucesso" : avaliation.status
        }
        title = buttonType.rawValue
    }
}
