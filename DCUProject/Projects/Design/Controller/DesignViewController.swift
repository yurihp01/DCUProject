//
//  DesignViewController.swift
//  DCUProject
//
//  Created by PRO on 16/03/2022.
//

import UIKit

class DesignViewController: BaseViewController {

    @IBOutlet weak var prototypeImage: UIImageView!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    
    var picker: ImagePicker!
    
    weak var coordinator: DesignCoordinator?
    var viewModel: DesignViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImagePicker()
        checkOwner()
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let tappedImage = tapGestureRecognizer.view as? UIImageView else { return }

        picker.present(from: tappedImage)
    }
    
    @IBAction func addButtonTouched(_ sender: UIButton) {
        guard let image = selectedImage.image else { return }
        indicator.startAnimating()
        viewModel?.saveImage(image: image)
        addButton.isEnabled = false

    }
}

private extension DesignViewController {
    func checkOwner() {
        if let email = viewModel?.getCurrentUser()?.email,
           let projectOwner = viewModel?.project.owner,
           !email.elementsEqual(projectOwner) {
            addButton.isEnabled = false
            prototypeImage.isUserInteractionEnabled = false
        }
    }
    
    func addTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            prototypeImage.isUserInteractionEnabled = true
        prototypeImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func addImagePicker() {
        self.picker = ImagePicker(presentationController: self, delegate: self)
        addTapGesture()
    }
}

extension DesignViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        selectedImage.image = image
        addButton.isEnabled = true
    }
    
    
}