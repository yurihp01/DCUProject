//
//  BorderedButton.swift
//  SantanderEmpresasNative
//
//  Created by PRO on 02/03/2022.
//

import UIKit

enum BorderedButtonStyle {
    case blue
    case white
}

class BorderedButton: UIButton {
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var style: BorderedButtonStyle = .blue {
        didSet {
            switch style {
            case .blue:
                self.setTitleColor(.white, for: .normal)
                self.layer.backgroundColor = UIColor.systemBlue.cgColor
                self.layer.borderColor = UIColor.systemBlue.cgColor
            case .white:
                self.setTitleColor(.systemBlue, for: .normal)
                self.layer.backgroundColor = UIColor.white.cgColor
                self.layer.borderColor = UIColor.systemBlue.cgColor
            }
            setButton()
        }
    }

    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setButton()
    }
}

private extension BorderedButton {
    func setButton() {
        setRoundedBorder()
        layer.borderWidth = 1
    }
}

extension UIView {
    func setRoundedBorder(cornerRadius: CGFloat? = nil) {
        layer.cornerRadius = cornerRadius ?? (bounds.height / 2)
        clipsToBounds = true
        layer.masksToBounds = false
    }
}
