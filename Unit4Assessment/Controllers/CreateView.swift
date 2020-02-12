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
        textField.placeholder = "FRONT OF CARD: Answer/Question here"
        //number of lines
        textField.textAlignment = .center
        textField.backgroundColor = .systemTeal
        return textField
    }()
    
    public lazy var flashCardDetailOne: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .headline)
//        textView.text = " BACK OF CARD: Details or Answer here."
//        textView.textColor = .systemGray2
        textView.textAlignment = .left
        textView.backgroundColor = .systemTeal
        return textView
    }()
    
    public lazy var flashCardDetailTwo: UITextView = {
        let textview = UITextView()
        textview.font = UIFont.preferredFont(forTextStyle: .headline)
        textview.textAlignment = .left
//        textview.text = " BACK OF CARD: Details or Answer here."
//        textview.textColor = .systemGray2
        textview.backgroundColor = .systemTeal
        return textview
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
            flashCardAnswer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            //flashCardAnswer.centerXAnchor.constraint(equalTo: centerXAnchor),
            flashCardAnswer.heightAnchor.constraint(equalToConstant: 40),
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
            flashCardDetailOne.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setUpFlashCardDetailTwoConstraint() {
        addSubview(flashCardDetailTwo)
        flashCardDetailTwo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flashCardDetailTwo.topAnchor.constraint(equalTo: flashCardDetailOne.bottomAnchor, constant: 20),
            flashCardDetailTwo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            flashCardDetailTwo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            flashCardDetailTwo.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}
