//
//  CardsCollectionViewCell.swift
//  Unit4Assessment
//
//  Created by Melinda Diaz on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

//TODO: Create a custom Delegate and protocol here


class CardsCollectionViewCell: UICollectionViewCell {
    
    
    private var currentFlashCards: FlashCards!
    
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
        return label
    }()
    
    public lazy var flashCardDetailTextFieldOne: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.text = "This is where the first detail is"
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = .systemYellow
        return textView
    }()
    
    public lazy var flashCardDetailTextFieldTwo: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.text = "This is where the second detail is"
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = .systemTeal
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
    
    //TODO: Finish Gesture DIDLongPress and Animate func check saved cell
    
    @objc private func moreButtonPressed(_ sender: UIButton) {
        //TODO:Step3: Custom Protocol
        // delegate?.didSelectMoreButton(self, article: currentArticle)
        //MARK: Delete after
        print("button was pressed for flashCards, This is just for TEST PURPOSES you delete it after")
        
    }
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard currentFlashCards != nil else { return }
        print("button was longpressed for flashCards, TEST PURPOSES")
        if gesture.state == .began || gesture.state == .changed {
            return
        }
        isShowingDetails.toggle()
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
            //TODO: Doublecheck the height of the textfields
            
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
            //TODO: Doublecheck the height of the textfields
            
        ])
        
    }
    //TODO: Fix this it works better with cards
    public func configureCell(for savedCards: FlashCards) {
          currentFlashCards = savedCards
        //flashCardAnswerTitle.text = currentFlashCards.cardTitle
      }
}
