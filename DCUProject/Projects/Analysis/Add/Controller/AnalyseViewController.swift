//
//  AnalyseViewController.swift
//  DCUProject
//
//  Created by PRO on 10/03/2022.
//

import UIKit

class AnalyseViewController: BaseViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var name: FloatingLabelField!
    @IBOutlet weak var detail: UITextView!
    
    weak var coordinator: AnalyseCoordinator?
    
    var viewModel: AnalyseProtocol?
    var segmentedType = AnalyseType.persona
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewsVisibility()
        setViews()
        setNavigationBar()
        
        detail.delegate = self
        detail.layer.borderColor = UIColor.gray.cgColor
        detail.layer.borderWidth = 0.2
        detail.layer.cornerRadius = 4
        detail.clipsToBounds = true
        
        detail.textColor = .lightGray

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
        detail.textColor = detail.text.isEmpty ? .lightGray : .black
        segmentedControl.selectedSegmentIndex = AnalyseType(rawValue: analyse.type)?.getTypeId ?? 0
        
    }
    
    func setViewsVisibility() {
        detail.isEditable = viewModel?.buttonType == .edit ? false : true
        name.isEnabled = detail.isEditable
        segmentedControl.isEnabled = detail.isEditable
    }
    
    func saveAnalyse(complete: @escaping () -> ()) {
        guard var viewModel = viewModel,
              let name = name.text, !name.isEmpty,
              let detail = detail.text, !detail.isEmpty else {
            showAlert(message: "O campo definição está vazio. Preencha e tente novamente!")
            return
        }
        showLoading(view: view)

        let analyse = Analyse(detail: detail, type: segmentedType, name: name)
        
        if viewModel.type == .insert {
            viewModel.project.analysis.append(analyse)
        } else if let row = viewModel.project.analysis.firstIndex(where: { $0.id == viewModel.analyse?.id }) {
            viewModel.project.analysis[row] = analyse
        }
        
        viewModel.addAnalyse { [weak self] result in
            self?.stopLoading()
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
    func textViewDidBeginEditing (_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.textColor = UIColor.black
            textView.text = ""
        }
    }
}
