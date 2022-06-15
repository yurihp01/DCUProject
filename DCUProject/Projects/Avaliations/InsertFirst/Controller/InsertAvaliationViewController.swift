//
//  InsertAvaliationViewController.swift
//  DCUProject
//
//  Created by PRO on 05/03/2022.
//

import UIKit

class CellClass: UITableViewCell {}

class InsertAvaliationViewController: BaseViewController {
    
    @IBOutlet weak var screen: FloatingLabelField!
    @IBOutlet weak var heuristic: FloatingLabelField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackStatus: UIStackView!
    
    @IBOutlet weak var status: FloatingLabelField!
    @IBOutlet weak var severity: FloatingLabelField!
    @IBOutlet weak var button: BorderedButton!
    @IBOutlet weak var avaliator: FloatingLabelField!
    @IBOutlet weak var titleField: FloatingLabelField!
    
    let transparentView = UIView()
    let tableView = UITableView()
    var dataSource = [String]()
    var selectedField = FloatingLabelField()
    
    weak var coordinator: InsertAvaliationCoordinator?
    var viewModel: InsertAvaliationViewModel?
    var buttonType: ButtonType = .save
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields()
        setDropdowns()
        button.style = .blue
    }
        
    @IBAction func buttonTouched(_ sender: UIButton) {
        guard let project = viewModel?.project else { return }
        
        if project.preAvaliation.screens.isEmpty {
            showAlert(message: "Não há telas previamente cadastradas. Insira, ao menos, uma no menu Pré-Avaliação e tente novamente!")
            return
        }
        
        if project.preAvaliation.heuristics.isEmpty {
            showAlert(message: "Não há heurísticas previamente cadastradas. Insira, ao menos, uma no menu Pré-Avaliação e tente novamente!")
            return
        }
        
        if let title = title,
           let viewModel = viewModel, checkFields() {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd/MM/yyyy"
            let date = viewModel.avaliation?.date ?? dateFormat.string(from: Date())
            var avaliation = Avaliation(title: titleField.text!, date: date, screen: screen.text!, heuristic: heuristic.text!, avaliator: avaliator.text!, comments: viewModel.avaliation?.comments ?? "", status: status.text!)
            avaliation.id = viewModel.avaliation?.id ?? UUID().uuidString
            
            if !severity.isEnabled {
                avaliation.status = status.text!
            } else if let severity = severity.text, !severity.isEmpty {
                avaliation.status = severity
            } else {
                showAlert(message: "Selecione uma severidade e tente novamente!")
            }
            
            coordinator?.goToInsertSecondPart(project: viewModel.project, avaliation: avaliation, title: title)
        }
    }
}

private extension InsertAvaliationViewController {
    func checkFields() -> Bool {
        if screen.text!.isEmpty || screen.text == nil {
            showAlert(message: "O campo tela está vazio. Preencha e tente novamente!")
            return false
        }
      
        if heuristic.text!.isEmpty || heuristic.text == nil {
            showAlert(message: "O campo heurística está vazio. Preencha e tente novamente!")
            return false
        }
        
        if avaliator.text!.isEmpty || avaliator.text == nil {
            showAlert(message: "O campo avaliador está vazio. Preencha e tente novamente!")
            return false
        }
        
        if status.text!.isEmpty || status.text == nil {
            showAlert(message: "O campo status está vazio. Preencha e tente novamente!")
            return false
        }
        
        if titleField.text!.isEmpty || titleField.text == nil {
            showAlert(message: "O campo título está vazio. Preencha e tente novamente!")
            return false
        }
        
        return true
    }
    
    func addTransparentView(frames: CGRect) {
         transparentView.frame = self.view.frame
         self.view.addSubview(transparentView)
         
        tableView.frame = CGRect(x: stackView.frame.minX, y: frames.origin.y + stackView.frame.minY, width: stackView.frame.width, height: CGFloat(dataSource.count * 50))
         self.view.addSubview(tableView)
         tableView.layer.cornerRadius = 5
         
         transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
         tableView.reloadData()
         let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
         transparentView.addGestureRecognizer(tapgesture)
             self.transparentView.alpha = 0.5
     }
        
    @objc func removeTransparentView() {
         let frames = selectedField.frame
         self.transparentView.alpha = 0
         self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
     }
    
    func setDropdowns() {
        screen.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        heuristic.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        status.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        severity.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        severity.isEnabled = status.text == "Defeito"
        screen.image.isHidden = false
        screen.delegate = self
        heuristic.delegate = self
        status.delegate = self
        severity.delegate = self
        heuristic.image.isHidden = false
        status.image.isHidden = false
        severity.image.isHidden = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
    }
        
    func setFields() {
        if let avaliation = viewModel?.avaliation {
            buttonType = .edit
            titleField.text = avaliation.title
            screen.text = avaliation.screen
            heuristic.text = avaliation.heuristic
            avaliator.text = avaliation.avaliator
            status.text = avaliation.status == "Sucesso" ? "Sucesso" : "Defeito"
            severity.text = avaliation.status == "Sucesso" ? "" : avaliation.status
        }
        title = buttonType.rawValue
    }
    
    @objc func myTargetFunction(textField: FloatingLabelField) {
        guard let project = viewModel?.project else { return }
        switch textField {
        case screen:
            dataSource = project.preAvaliation.screens
            selectedField = textField
            addTransparentView(frames: textField.frame)
        case heuristic:
            dataSource = project.preAvaliation.heuristics
            selectedField = textField
            addTransparentView(frames: textField.frame)
        case status:
            dataSource = ["Sucesso", "Defeito"]
            selectedField = textField
            addTransparentView(frames: stackStatus.frame)
        case severity:
            dataSource = [Severity.cosmetic.rawValue, Severity.lower.rawValue, Severity.serious.rawValue, Severity.disaster.rawValue]
            selectedField = textField
            addTransparentView(frames: stackStatus.frame)
        default:
            break
        }
    }
}

extension InsertAvaliationViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataSource.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = dataSource[indexPath.row]
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if selectedField == status {
                severity.isEnabled = dataSource[indexPath.row] == "Defeito"
                severity.text = dataSource[indexPath.row] == "Defeito"  ? severity.text : ""
            }
            selectedField.text = dataSource[indexPath.row]
            removeTransparentView()
        }
    }

extension InsertAvaliationViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case screen, heuristic, status, severity:
            return false
        default:
            return true
        }
    }
}
