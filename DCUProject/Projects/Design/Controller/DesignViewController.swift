//
//  DesignViewController.swift
//  DCUProject
//
//  Created by PRO on 16/03/2022.
//

import UIKit
import Kingfisher

class DesignViewController: BaseViewController {

    @IBOutlet weak var insertButton: BorderedButton!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var addButton: BorderedButton!
    var picker: ImagePicker!
    
    weak var coordinator: DesignCoordinator?
    var viewModel: DesignViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImagePicker()
        getImage()
        addButton.style = .blue
        insertButton.style = .white
        selectedImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageSelectedTapped)))

    }
    
    func getImage() {
        if let url = viewModel?.project?.design,
           !url.isEmpty {
            let processor = DownsamplingImageProcessor(size: selectedImage.bounds.size)
            selectedImage.kf.indicatorType = .activity
            selectedImage.kf.setImage(
                with: URL(string: url),
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    self.selectedImage.isUserInteractionEnabled = true
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure:
                    self.showAlert(message: "Não foi possível carregar a imagem. Verifique a sua conexão a internet e tente novamente.")
                }
            }
        }
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
                self?.selectedImage.image = nil
            }
        })
        addButton.isEnabled = false
    }
    
    @IBAction func addInsertButtonTouched(_ sender: UIButton) {
        picker.present(from: sender)
    }
    
    @objc func imageSelectedTapped(_ sender: UITapGestureRecognizer) {
        let newImageView = UIImageView(image: selectedImage.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.7)
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}

private extension DesignViewController {
    func addImagePicker() {
        self.picker = ImagePicker(presentationController: self, delegate: self)
    }
}

extension DesignViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        selectedImage.image = image
        selectedImage.isUserInteractionEnabled = true
        addButton.isEnabled = true
        
    }
}
