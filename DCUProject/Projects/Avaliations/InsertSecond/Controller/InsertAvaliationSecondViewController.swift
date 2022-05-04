//
//  DetailsViewController.swift
//  DCUProject
//
//  Created by PRO on 05/03/2022.
//

import UIKit

class InsertAvaliationSecondViewController: BaseViewController {
    
    @IBOutlet weak var comments: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var button: BorderedButton!
    
    weak var coordinator: InsertAvaliationSecondCoordinator?
    var viewModel: InsertAvaliationSecondViewModel?
    var buttonType: ButtonType = .save
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields()
        setDatePicker()
        button.style = .blue
        comments.delegate = self
        comments.resignFirstResponder()
        comments.layer.borderColor = UIColor.gray.cgColor
        comments.layer.borderWidth = 0.2
        comments.layer.cornerRadius = 4
        comments.clipsToBounds = true
        comments.textColor = .lightGray
        comments.text = "Digite um comentário"
    }

    @IBAction func buttonTouched(_ sender: UIButton) {
        guard let comments = comments.text,
              let viewModel = viewModel else { return }
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        viewModel.avaliation.date = dateFormat.string(from: datePicker.date)
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
        if viewModel.avaliation.comments.isEmpty {
            comments.textColor = .lightGray
            comments.text = "Digite um comentário"
        } else {
            comments.text = viewModel.avaliation.comments
            comments.textColor = .black
        }
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        datePicker.date = dateFormat.date(from: viewModel.avaliation.date) ?? Date()
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

extension InsertAvaliationSecondViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.textColor = UIColor.black
            textView.text = ""
        }
    }
}
