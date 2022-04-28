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
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let tappedImage = tapGestureRecognizer.view as? UIImageView else { return }

        picker.present(from: tappedImage)
    }
    
    @IBAction func addButtonTouched(_ sender: UIButton) {
        guard let image = selectedImage.image else { return }
        showLoading(view: view)
        viewModel?.uploadMedia(image: image, completion: { [weak self] result in
            self?.stopLoading()
            switch result {
            case .success(let message):
                self?.showMessage(message: message)
            case .failure(let error):
                self?.showAlert(message: error.errorDescription)
            }
        })
        addButton.isEnabled = false
    }
}

private extension DesignViewController {
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
