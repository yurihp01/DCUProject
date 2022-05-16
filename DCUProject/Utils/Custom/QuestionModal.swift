//
//  QuestionModal.swift
//  DCUProject
//
//  Created by Yuri on 15/05/2022.
//

import UIKit

class QuestionModal: UIView {
    @IBOutlet weak var questionField: FloatingLabelField!
    @IBOutlet weak var answerView: UITextView!
    @IBOutlet weak var button: BorderedButton!
    
    private var delegate: AnalysisDelegate?
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = .darkGray
        label.text = "Resposta"
        label.font = .systemFont(ofSize: 12)
        label.layer.backgroundColor = UIColor.white.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.frame = CGRect(x: 0, y: 0, width: answerView.frame.size.width, height: 14)
        addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(frame: frame)
        setAnswer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func xibSetup(frame: CGRect) {
        let view = loadXib()
        view.frame = frame
        view.backgroundColor = .clear.withAlphaComponent(0.3)
        addSubview(view)
    }
    
    func loadXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let modal = UINib(nibName: "QuestionModal", bundle: bundle)
        let view = modal.instantiate(withOwner: self).first as? UIView
        return view!
    }
    
    func setAnswer() {
        button.style = .blue
        answerView.layer.borderColor = UIColor.gray.cgColor
        answerView.layer.borderWidth = 0.2
        answerView.layer.cornerRadius = 4
        answerView.clipsToBounds = true
        label.bottomAnchor.constraint(equalTo: answerView.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: answerView.leftAnchor).isActive = true
    }
    
    func setFields(question: String, answer: String = "", delegate: AnalysisDelegate) {
        questionField.text = question
        answerView.text = answer
        self.delegate = delegate
    }
    
    @IBAction func buttonTouched(_ sender: Any) {
        if let text = questionField.text,
           !text.isEmpty {
            
            let question: Question
            
            if let answer = answerView.text, !answer.isEmpty {
                question = Question(question: text, answer: text)
            } else {
                question =  Question(question: text)
            }
            
            delegate?.onButtonClicked(question: question)
        }
        
//        showAlert(message: "Insira uma pergunta e tente novamente!")
        
    }
    
}
