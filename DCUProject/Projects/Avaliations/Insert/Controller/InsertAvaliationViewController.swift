//
//  DetailsViewController.swift
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
    @IBOutlet weak var comments: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var button: UIButton!
    
    weak var coordinator: InsertAvaliationCoordinator?
    var viewModel: InsertAvaliationViewModel?
    var buttonType: ButtonType = .save
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields()
        setDropdowns()
        setDatePicker()
        checkOwner()
    }
    
//    MARK: - Corrigir erros no layout e inserir valores no dropdown
    
    @IBAction func buttonTouched(_ sender: UIButton) {
        if  let screen = screen.text, !screen.isEmpty,
            let heuristic = heuristic.text, !heuristic.isEmpty,
            let avaliator = avaliator.text, !avaliator.isEmpty,
                let status = status.text, !status.isEmpty,
            let comments = comments.text, !comments.isEmpty
        {
            if !severity.isEnabled {
                viewModel?.avaliation = Avaliation(screen: screen, heuristic: heuristic, avaliator: avaliator, comments: comments, status: status, date: datePicker.date)
            } else if let severity = severity.text {
                viewModel?.avaliation = Avaliation(screen: screen, heuristic: heuristic, avaliator: avaliator, comments: comments, status: severity, date: datePicker.date)
            }
        } else {
               showAlert(message: "Ainda há campos a serem preenchidos. Verifique e tente novamente!")
               return
        }
        
        if buttonType == .save {
            viewModel?.addAvaliation(completion: { [self] message in
                message.contains("sucesso") ? showMessage(message: "Projeto alterado com sucesso!", handler: nil)
                : showAlert(message: message)
            })
        }
        
//      arrumar erros que estão na classe
        switchViews()
    }
}

private extension InsertAvaliationViewController {
    func checkOwner() {
//        if let email = viewModel?.getCurrentUser()?.email,
//           let projectOwner = viewModel?.project.owner,
//           !email.elementsEqual("sarahcampinho@hotmail.com") {
//            button.isEnabled = false
//        }
    }
    
    func setDropdowns() {
        guard let viewModel = viewModel else { return }
        let project = viewModel.firebase.project
        screen.optionArray = project?.preAvaliation?.screens ?? []
        heuristic.optionArray = project?.preAvaliation?.heuristics ?? []
        status.optionArray = ["Sucesso", "Defeito"]
        severity.optionArray = [Severity.cosmetic.rawValue, Severity.lower.rawValue, Severity.serious.rawValue, Severity.disaster.rawValue]
        
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
            comments.text = avaliation.comments
            datePicker.date = avaliation.date
            toggleViews()
        }
        
        button.setTitle(buttonType.rawValue, for: .normal)
        coordinator?.navigationController.navigationItem.rightBarButtonItem?.title = buttonType.rawValue
    }
    
    func switchViews() {
        buttonType.toggle()
        coordinator?.navigationController.navigationItem.rightBarButtonItem?.title = buttonType.rawValue
        toggleViews()
        button.setTitle(buttonType.rawValue, for: .normal)
    }
    
    func toggleViews() {
        screen.isEnabled.toggle()
        heuristic.isEnabled.toggle()
        avaliator.isEnabled.toggle()
        datePicker.isEnabled.toggle()
        status.isEnabled.toggle()
        severity.isEnabled.toggle()
        comments.isEnabled.toggle()
    }
    
    func setDatePicker() {
        datePicker.maximumDate = Date()
    }
}
