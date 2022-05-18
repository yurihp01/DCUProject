//
//  BaseViewController.swift
//  DCUProject
//
//  Created by Yuri Pedroso on 19/02/22.
//

import UIKit

class BaseViewController: UIViewController, Storyboarded {
    
    // MARK: Variables
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        activityIndicator.backgroundColor = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    func showAlert(message: String?) {
        guard let message = message else { return }
        let alert = UIAlertController.showAlertDialog(title: Constants.titleError, message: message)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMessage(message: String?, handler: ((UIAlertAction) -> ())? = nil) {
        guard let message = message else { return }
        let alert = UIAlertController.showAlertDialog(title: "Sucesso", message: message, handler: handler)
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertWithTextField(title: String? = nil, message: String? = nil, placeholder: String? = nil, completion: @escaping ((String) -> Void) = { _ in }) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField() { newTextField in
            newTextField.placeholder = placeholder
            newTextField.addDoneButtonOnKeyboard()
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in return })
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            if
                let textFields = alert.textFields,
                let tf = textFields.first,
                let result = tf.text
            { completion(result) }
            else
            { completion("") }
        })
        navigationController?.present(alert, animated: true)
    }
    
    func showLoading(view: UIView) {
        view.addSubview(activityIndicator)
        
        activityIndicator.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        activityIndicator.startAnimating()
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
