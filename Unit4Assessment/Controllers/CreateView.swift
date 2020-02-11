//
//  CreateView.swift
//  Unit4Assessment
//
//  Created by Melinda Diaz on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateView: UIView {
    
    public lazy var flashCardAnswer: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .headline)
        textField.textAlignment = .center
        textField.backgroundColor = .systemTeal
        return textField
    }()
    
    public lazy var flashCardDetailOne: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .headline)
        textField.textAlignment = .left
        textField.backgroundColor = .systemTeal
        return textField
    }()
    //TODO: Erase??
//    public lazy var flashCardDetailOne: UITextView = {
//        let textView = UITextView()
//        textView.font = UIFont.preferredFont(forTextStyle: .body)
//        textView.backgroundColor = .systemPink
//        textView.textAlignment = .left
//        return textView
//    }()
    
//    public lazy var flashCardDetailTwo: UITextView = {
//        let textView = UITextView()
//        textView.font = UIFont.preferredFont(forTextStyle: .body)
//        textView.backgroundColor = .systemPink
//        textView.textAlignment = .left
//        return textView
//
//    }()
    
    public lazy var flashCardDetailTwo: UITextField = {
           let textField = UITextField()
           textField.font = UIFont.preferredFont(forTextStyle: .headline)
           textField.textAlignment = .left
           textField.backgroundColor = .systemTeal
           return textField
       }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpFlashCardAnswerConstraint()
        setUpFlashCardDetailOneConstraint()
        setUpFlashCardDetailTwoConstraint()
    }
    
    private func setUpFlashCardAnswerConstraint() {
        addSubview(flashCardAnswer)
        flashCardAnswer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flashCardAnswer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            flashCardAnswer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            flashCardAnswer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setUpFlashCardDetailOneConstraint() {
        addSubview(flashCardDetailOne)
        flashCardDetailOne.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flashCardDetailOne.topAnchor.constraint(equalTo: flashCardAnswer.bottomAnchor, constant: 20),
            flashCardDetailOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            flashCardDetailOne.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            flashCardDetailOne.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setUpFlashCardDetailTwoConstraint() {
        addSubview(flashCardDetailTwo)
        flashCardDetailTwo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flashCardDetailTwo.topAnchor.constraint(equalTo: flashCardDetailOne.bottomAnchor, constant: 20),
            flashCardDetailTwo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            flashCardDetailTwo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            flashCardDetailTwo.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
