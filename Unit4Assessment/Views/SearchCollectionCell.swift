//
//  SearchCollectionCell.swift
//  Unit4Assessment
//
//  Created by Melinda Diaz on 2/12/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol SavedFlashCardCellDelegate: AnyObject {
    func didSelectMoreButton(_ savedFlashCards: SearchCollectionCell, flashCards: FlashCards)
}


class SearchCollectionCell: UICollectionViewCell {
    
    
    private var searchedCard: FlashCards!
    //TODO:
   // weak var delegate = SavedFlashCardCellDelegate?
    
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
          addGestureRecognizer(longPressedGesture)
          flashCardAnswerTitle.isUserInteractionEnabled = true
          setUpFlashCardDetailTextFieldOne()
          setUpFlashCardDetailTextFieldTwo()
      }
    
    
       @objc private func moreButtonPressed(_ sender: UIButton) {
           //TODO:Step3: Custom Protocol
        
      // delegate?.didSelectMoreButton(self, flashCards: searchedCard)
           //MARK: Delete after
           print("button was pressed for flashCards, This is just for TEST PURPOSES you delete it after")
           
       }
    
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard searchedCard != nil else { return }
        print("button was longpressed for flashCards, TEST PURPOSES ")
                 
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
}
