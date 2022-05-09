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
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = .darkGray
        label.text = "Detalhes"
        label.font = .systemFont(ofSize: 12)
        label.layer.backgroundColor = UIColor.white.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.frame = CGRect(x: 0, y: 0, width: comments.frame.size.width, height: 14)
        view.addSubview(label)
        return label
    }()
    
    weak var coordinator: InsertAvaliationSecondCoordinator?
    var viewModel: InsertAvaliationSecondViewModel?
    var buttonType: AvaliationButtonType = .save
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields()
        setDatePicker()
        button.style = .blue
        comments.layer.borderColor = UIColor.gray.cgColor
        comments.layer.borderWidth = 0.2
        comments.layer.cornerRadius = 4
        comments.clipsToBounds = true
        label.bottomAnchor.constraint(equalTo:
        comments.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo:
        comments.leftAnchor).isActive = true
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
            case .success:
                self?.showMessage(message: self?.buttonType == .save ? "Avaliação adicionada com sucesso!" : "Avaliação alterada com sucesso!", handler: { _ in
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
