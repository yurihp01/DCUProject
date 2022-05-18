//
//  AnalysisViewController.swift
//  DCUProject
//
//  Created by PRO on 06/03/2022.
//

import UIKit

protocol AnalysisDelegate: AnyObject {
    func onButtonClicked(question: Question, modal: QuestionModal)
    func onButtonClicked(question: Question, modal: QuestionModal, indexPath: IndexPath)
    func showAlert()
}

class AnalysisViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var analyseSegmentedControl: UISegmentedControl!
    @IBOutlet weak var addButton: BorderedButton!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var nameField: FloatingLabelField!
    @IBOutlet weak var textView: UITextView!
    
    weak var coordinator: AnalysisCoordinator?
    var viewModel: AnalysisViewModelProtocol?
    var homeDelegate: HomeViewDelegate?
    var analyseType: AnalyseType = .persona
    var buttonType: AvaliationButtonType = .save
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = .darkGray
        label.text = "Descrição da Análise"
        label.font = .systemFont(ofSize: 12)
        label.layer.backgroundColor = UIColor.white.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.frame = CGRect(x: 0, y: 0, width: textView.frame.size.width, height: 14)
        segmentView.addSubview(label)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
        addButton.style = .blue
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 0.2
        textView.layer.cornerRadius = 4
        textView.clipsToBounds = true
        label.bottomAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: textView.leftAnchor).isActive = true
        setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            segmentView.isHidden = false
            tableView.isHidden = true
            analyseType = .persona
        case 1:
            analyseType = .quiz
            segmentView.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
        case 2:
            analyseType = .interview
            segmentView.isHidden = false
            tableView.isHidden = true
        default:
            print("Error")
        }
        tableView.reloadData()
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        
        if analyseSegmentedControl.selectedSegmentIndex == 1 {
            let modal = QuestionModal(frame: view.frame)
            modal.setFields(delegate: self, question: "")
            view.addSubview(modal)
        } else if buttonType == .save, checkFields() {
            let analyse = Analyse(detail: textView.text, type: analyseType, name: nameField.text!)
            viewModel?.project?.analyse = analyse
        }
        
        setViewsVisibility()
    }
}

private extension AnalysisViewController {
    func setViewsVisibility() {
        if analyseSegmentedControl.selectedSegmentIndex != 1 {
            nameField.isEnabled.toggle()
            textView.isEditable.toggle()
            buttonType.toggle()
            addButton.setTitle(buttonType.rawValue, for: .normal)
        }
    }
    
    func setDelegation() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setViews() {
        guard let analyse = viewModel?.project?.analyse,
              !analyse.name.isEmpty else { return }
        nameField.text = analyse.name
        textView.text = analyse.detail
        analyseSegmentedControl.selectedSegmentIndex = AnalyseType(rawValue: analyse.type)?.getTypeId ?? 0
        buttonType = .edit
        addButton.setTitle(buttonType.rawValue, for: .normal)
    }
    
    func checkFields() -> Bool {
        if nameField.text!.isEmpty || nameField.text == nil {
            showAlert(message: "O campo título está vazio. Preencha e tente novamente!")
            return false
        }
      
        if textView.text!.isEmpty || textView.text == nil {
            showAlert(message: "O campo descrição está vazio. Preencha e tente novamente!")
            return false
        }
        return true
    }
}

extension AnalysisViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let questions = viewModel?.getAnalysis(by: searchBar.text),
              questions.count > 0 else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = questions[indexPath.row].question
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let question = viewModel?.getAnalysis(by: searchBar.text)[indexPath.row] else { return }
        let modal = QuestionModal(frame: view.frame)
        modal.setFields(delegate: self, question: question.question, answer: question.answer, indexPath: indexPath)
        view.addSubview(modal)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getAnalysis(by: searchBar.text).count ?? 0
    }
}

extension AnalysisViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
    }
}

extension AnalysisViewController: AnalysisDelegate {
    func showAlert() {
        showAlert(message: "Insira uma pergunta e tente novamente!")
    }
    
    func onButtonClicked(question: Question, modal: QuestionModal, indexPath: IndexPath) {
        var project = viewModel?.project
        project?.analyse.questions[indexPath.row] = question
        addAnalyse(modal: modal, project: project)
    }
    
    func onButtonClicked(question: Question, modal: QuestionModal) {
        var project = viewModel?.project
        project?.analyse.questions.append(question)
        addAnalyse(modal: modal, project: project)
//        ver o porque nao está pegando o ID do projeto.
//        corrigir botoes de inserir e editar na analise
//
    }
    
    func addAnalyse(modal: QuestionModal, project: Project?) {
        
        viewModel?.addAnalyse(project: project, onCompletion: { [weak self] result in
            switch result {
            case .success(let message):
                self?.showMessage(message: message)
                self?.tableView.reloadData()
            case .failure(let error):
                self?.showAlert(message: error.errorDescription)
            }
            modal.removeFromSuperview()
        })
    }
}
