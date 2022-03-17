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
    
    var picker: ImagePicker!
    
    weak var coordinator: DesignCoordinator?
    var viewModel: DesignViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImagePicker()
        addTapGesture()
    }

        @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
        {
            guard let tappedImage = tapGestureRecognizer.view as? UIImageView else { return }

            picker.present(from: tappedImage)
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
    }
    
    
}
