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
        guard let comments = comments.text,
              let viewModel = viewModel else { return }
        viewModel.avaliation.date = datePicker.date.description
        viewModel.avaliation.comments = comments
         
        viewModel.addAvaliation(completion: { [weak self] result in
            switch result {
            case .success(let message):
                self?.showMessage(message: message, handler: { _ in
                    self?.navigationController?.popToViewController(ofClass: HomeViewController.self)
                })
            case .failure(let error):
                self?.showAlert(message: error.errorDescription)
            }
        })
    }
}

private extension InsertAvaliationSecondViewController {
    func setFields() {
        guard let viewModel = viewModel else { return }
        comments.text = viewModel.avaliation.comments
        datePicker.date = DateFormatter().date(from: viewModel.avaliation.date) ?? Date()
        button.setTitle(viewModel.title, for: .normal)
        title = viewModel.title
    }
    
    func setDatePicker() {
        datePicker.maximumDate = Date()
    }
}

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
