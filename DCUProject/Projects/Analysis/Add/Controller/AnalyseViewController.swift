//
//  AnalyseViewController.swift
//  DCUProject
//
//  Created by PRO on 10/03/2022.
//

import UIKit

class AnalyseViewController: BaseViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var detail: UITextView!
    
    weak var coordinator: AnalyseCoordinator?
    
    var viewModel: AnalyseProtocol?
    var segmentedType = AnalyseType.persona
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewsVisibility()
        setViews()
        setTextView()
        setNavigationBar()
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            segmentedType = AnalyseType.persona
        case 1:
            segmentedType = AnalyseType.quiz
        case 2:
            segmentedType = AnalyseType.interview
        default:
            print("Error")
        }
    }
}

private extension AnalyseViewController {
    func setViews() {
        guard let analyse = viewModel?.analyse else { return }
        name.text = analyse.name
        detail.text = analyse.detail
        segmentedControl.selectedSegmentIndex = AnalyseType(rawValue: analyse.type)?.getTypeId ?? 0
    }
    
    func setViewsVisibility() {
        detail.isEditable = viewModel?.buttonType == .edit ? false : true
        name.isEnabled = detail.isEditable
        segmentedControl.isEnabled = detail.isEditable
    }
    
    func setTextView() {
        guard let placeholder = viewModel?.placeholder else { return }
        detail.textColor = detail.text.contains(placeholder) ? .lightGray : .black
        detail.delegate = self
    }
    
    func saveAnalyse(complete: @escaping () -> ()) {
        guard var viewModel = viewModel,
              let name = name.text, !name.isEmpty,
              let detail = detail.text, !detail.isEmpty,
              !detail.contains(viewModel.placeholder) else {
            showAlert(message: "O campo definição está vazio. Preencha e tente novamente!")
            return
        }
        indicator.startAnimating()

        let analyse = Analyse(detail: detail, type: segmentedType, name: name)
        viewModel.project.analysis.append(analyse)
        viewModel.addAnalyse { [weak self] result in
            self?.indicator.stopAnimating()
            switch result {
            case .success:
                complete()
            case .failure(let error):
                self?.showAlert(message: error.errorDescription)
            }
        }
    }
    
    @objc func continueButtonPressed() {
        guard let coordinator = coordinator else { return }
                
        switch viewModel?.type {
        case .insert:
            saveAnalyse {
                self.showMessage(message: "Projeto salvo com sucesso!") { _ in
                    coordinator.stop()
                }
            }
        case .edit:
            if viewModel?.buttonType == .save {
                saveAnalyse {
                    self.showMessage(message: "Projeto alterado com sucesso!") { _ in
                        coordinator.stop()
                    }
                }
            }
            viewModel?.buttonType.toggle()
            navigationItem.rightBarButtonItem?.title = viewModel?.buttonType.rawValue
            setViewsVisibility()
        case .none:
            print("Error")
        }
    }
    
    func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: viewModel?.buttonType.rawValue, style: .plain, target: self, action: #selector(continueButtonPressed))
        navigationItem.rightBarButtonItem?.title = viewModel?.buttonType.rawValue
    }
}

extension AnalyseViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.textColor = UIColor.black
            textView.text = ""
        }
    }
}

