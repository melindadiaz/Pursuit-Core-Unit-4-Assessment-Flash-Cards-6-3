//
//  CardsCollectionViewCell.swift
//  Unit4Assessment
//
//  Created by Melinda Diaz on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit


protocol SavedFlashCardDelegate: AnyObject {
    func didSelectMoreButton(_ savedFlashCards: CardsCollectionViewCell, flashCards: Cards)
}

class CardsCollectionViewCell: UICollectionViewCell {
    
    public weak var delegate: SavedFlashCardDelegate?
    private var currentFlashCards: Cards!
    
    private lazy var longPressedGesture : UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(didLongPress(_:)))
        return gesture
    }()
    
    public lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    public lazy var flashCardAnswerTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "What is a FlashCard?"
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.alpha = 1.0
        return label
    }()
    
    public lazy var flashCardDetailTextFieldOne: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.text = "This is where the first detail is"
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = .systemYellow
        textView.alpha = 0.0
        return textView
    }()
    
    public lazy var flashCardDetailTextFieldTwo: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.text = "This is where the second detail is"
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = .systemTeal
        textView.alpha = 0.0
        return textView
    }()
    
    private var isShowingDetails = false
    //this helps toggle flashcards details on and off
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpMoreButtonConstraint()
        setUpFlashCardAnswerTitleConstraint()
        flashCardAnswerTitle.isUserInteractionEnabled = true
        addGestureRecognizer(longPressedGesture)
        setUpFlashCardDetailTextFieldOne()
        setUpFlashCardDetailTextFieldTwo()
    }
    
    
    
    @objc private func moreButtonPressed(_ sender: UIButton) {
        delegate?.didSelectMoreButton(self, flashCards: currentFlashCards)
    }
    
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard currentFlashCards != nil else { return }
        if gesture.state == .began || gesture.state == .changed {
            return
        }
        
        animate()
    }
    
    private func animate() {
        let duration: Double = 1.0
        print("animate ")
        if isShowingDetails {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.flashCardAnswerTitle.alpha = 1.0
                self.flashCardDetailTextFieldOne.alpha = 0.0
                self.flashCardDetailTextFieldTwo.alpha = 0.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.flashCardAnswerTitle.alpha = 0.0
                self.flashCardDetailTextFieldOne.alpha = 1.0
                self.flashCardDetailTextFieldTwo.alpha = 1.0
            }, completion: nil)
        }
        isShowingDetails.toggle()
    }
    
    private func setUpMoreButtonConstraint() {
        addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 44),
            moreButton.widthAnchor.constraint(equalTo: moreButton.heightAnchor)
        ])
    }
    
    private func setUpFlashCardAnswerTitleConstraint() {
        addSubview(flashCardAnswerTitle)
        flashCardAnswerTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flashCardAnswerTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            flashCardAnswerTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            flashCardAnswerTitle.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            flashCardAnswerTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setUpFlashCardDetailTextFieldOne() {
        addSubview(flashCardDetailTextFieldOne)
        flashCardDetailTextFieldOne.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flashCardDetailTextFieldOne.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            flashCardDetailTextFieldOne.leadingAnchor.constraint(equalTo: leadingAnchor),
            flashCardDetailTextFieldOne.trailingAnchor.constraint(equalTo: trailingAnchor),
            flashCardDetailTextFieldOne.heightAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    
    
    private func setUpFlashCardDetailTextFieldTwo() {
        addSubview(flashCardDetailTextFieldTwo)
        flashCardDetailTextFieldTwo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flashCardDetailTextFieldTwo.topAnchor.constraint(equalTo: flashCardDetailTextFieldOne.bottomAnchor, constant: 8),
            flashCardDetailTextFieldTwo.leadingAnchor.constraint(equalTo: leadingAnchor),
            flashCardDetailTextFieldTwo.trailingAnchor.constraint(equalTo: trailingAnchor),
            flashCardDetailTextFieldTwo.heightAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    
    public func configureCell(for savedCards: Cards) {
        currentFlashCards = savedCards
        flashCardAnswerTitle.text = savedCards.cardTitle
        flashCardDetailTextFieldOne.text = savedCards.facts.first
        flashCardDetailTextFieldTwo.text = savedCards.facts.last
    }
}
