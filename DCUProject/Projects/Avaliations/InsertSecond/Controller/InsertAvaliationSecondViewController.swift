//
//  DetailsViewController.swift
//  DCUProject
//
//  Created by PRO on 05/03/2022.
//

import iOSDropDown
import UIKit

class InsertAvaliationSecondViewController: BaseViewController {
    
    @IBOutlet weak var comments: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var button: UIButton!
    
    weak var coordinator: InsertAvaliationSecondCoordinator?
    var viewModel: InsertAvaliationSecondViewModel?
    var buttonType: ButtonType = .save
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields()
        setDatePicker()
    }

    @IBAction func buttonTouched(_ sender: UIButton) {
        if let comments = comments.text, !comments.isEmpty {
            viewModel?.avaliation?.date = datePicker.date
            viewModel?.avaliation?.comments = comments
        } else {
               showAlert(message: "Ainda há campos a serem preenchidos. Verifique e tente novamente!")
               return
        }
         
        viewModel?.addAvaliation(completion: { [self] message in
            message.contains("sucesso") ? showMessage(message: "Projeto salvo com sucesso!", handler: nil)
            : showAlert(message: message)
        })
    }
}

private extension InsertAvaliationSecondViewController {

    func setFields() {
        if let avaliation = viewModel?.avaliation,
           !avaliation.comments.isEmpty {
            buttonType = .edit
            comments.text = avaliation.comments
            datePicker.date = avaliation.date
        }
        
        button.setTitle(buttonType.rawValue, for: .normal)
        title = buttonType.rawValue
    }
    
    func setDatePicker() {
        datePicker.maximumDate = Date()
    }
}
