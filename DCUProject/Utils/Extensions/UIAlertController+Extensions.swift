//
//  .swift
//  DCUProject
//
//  Created by Yuri Pedroso on 19/02/22.
//

import UIKit

extension UIAlertController {
    // MARK: - Functions
    static func showAlertDialog(title: String, message: String, handler: ((UIAlertAction) -> ())? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.okButton, style: .default, handler: handler ?? nil)
        alert.addAction(okAction)
        return alert
    }
}
