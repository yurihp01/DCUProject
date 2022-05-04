//
//  FloatingLabelField.swift
//  DCUProject
//
//  Created by Yuri on 01/05/2022.
//

import UIKit

class FloatingLabelField: UITextField {
    var floatingLabel: UILabel = UILabel(frame: CGRect.zero) // Label
    var floatingLabelHeight: CGFloat = 14 // Default height
    
    lazy var image: UIImageView = {
        var image = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        image.image = UIImage(systemName: "arrowtriangle.down.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isHidden = true
        addSubview(image)
        image.rightAnchor.constraint(equalTo:
        self.rightAnchor, constant: -16).isActive = true
        image.centerYAnchor.constraint(equalTo:
        self.centerYAnchor).isActive = true
        return image
    }()
    
    @IBInspectable
    var _placeholder: String? // we cannot override 'placeholder'
    
    @IBInspectable
    var floatingLabelColor: UIColor = UIColor.darkGray {
        didSet {
            self.floatingLabel.textColor = floatingLabelColor
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var activeBorderColor: UIColor = UIColor.blue
    @IBInspectable
    var floatingLabelFont: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            self.floatingLabel.font = self.floatingLabelFont
            self.font = self.floatingLabelFont
            self.setNeedsDisplay()
        }
    }
    
    override var text: String? {
        didSet {
            self.floatingLabel.text = text == "" ? "" : placeholder
        }
    }
    
    func setvalues() {
        self._placeholder = (self._placeholder != nil) ? self._placeholder : placeholder // Use our custom placeholder if none is set
        placeholder = self._placeholder // make sure the placeholder is shown
        self.floatingLabel = UILabel(frame: CGRect.zero)
        backgroundColor = .white
        self.floatingLabel.textColor = floatingLabelColor
        self.floatingLabel.font = floatingLabelFont
        self.floatingLabel.text = text == "" ? "" : placeholder
        self.floatingLabel.layer.backgroundColor = UIColor.white.cgColor
        self.floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.floatingLabel.clipsToBounds = true
        delegate = self
        self.floatingLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.floatingLabelHeight)
        self.addSubview(self.floatingLabel)
        floatingLabel.bottomAnchor.constraint(equalTo:
        self.topAnchor, constant: 0).isActive = true
        
        
    }
    
    init (image: UIImage = UIImage()) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setvalues()
    }
    
    @objc func addFloatingLabel() {
        if self.text == "" {
            self.placeholder = ""
        }
        self.setNeedsDisplay()
    }
    
    @objc func removeFloatingLabel() {
        if self.text == "" {
            floatingLabel.text = nil
            placeholder = self._placeholder
        }
    }
}

extension FloatingLabelField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "" {
            if let text = textField.text,
               text.trimmingCharacters(in: .whitespaces).count <= 1 {
                floatingLabel.text = nil
                placeholder = self._placeholder
            } else {
                
            }
        } else {
            floatingLabel.text = placeholder
            
        }
        return true
    }
    
}
