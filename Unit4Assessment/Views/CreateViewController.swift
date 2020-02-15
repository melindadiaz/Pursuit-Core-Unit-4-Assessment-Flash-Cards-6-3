//
//  CreateViewController.swift
//  Unit4Assessment
//
//  Created by Melinda Diaz on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CreateViewController: UIViewController {
    
    public var dataPersistence: DataPersistence<Cards>!
    public var createFlashcards: Cards?
    private let createdView = CreateView()
    private var placeHolder = "BACK OF CARD: Details or Answer here."
    
    
    override func loadView() {
        view = createdView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        createdView.flashCardAnswer.delegate = self
        createdView.flashCardDetailOne.delegate = self
        createdView.flashCardDetailTwo.delegate = self
        createdView.flashCardDetailOne.text = placeHolder
        createdView.flashCardDetailTwo.text = placeHolder
        createdView.flashCardDetailOne.textColor = .lightGray
        createdView.flashCardDetailTwo.textColor = .lightGray
        navigationItem.title = "Create Custom Flashcards"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveCreatedFlashCardButtonPressed(_:)))
    }
    //TODO customFlashCardRequirements don't work
    private func customFlashCardRequirements() -> Bool {
        if ((createdView.flashCardAnswer.text) == nil) && ((createdView.flashCardDetailOne.text) == nil) && createdView.flashCardDetailTwo.text?.isEmpty == true {
            DispatchQueue.main.async {
                self.showAlert(title: "Not Successful", message: "You need to fill all fields in order to create a custom flash card.")
            }
            return false
        } else {
            showAlert(title: "Added this Flash Card", message: "You successfully added this to your flash card collection! You may now find this flash card in your FlashCards tab below")
            return true
        }
    }
    
    @objc func saveCreatedFlashCardButtonPressed(_ sender: UIBarButtonItem) {
        if customFlashCardRequirements() {
            do {
                //methodwise initializer
                let flashcard = Cards(id: "", cardTitle: createdView.flashCardAnswer.text ?? "", facts: [ createdView.flashCardDetailOne.text, createdView.flashCardDetailTwo.text])
                try dataPersistence.createItem(flashcard)
                
            } catch {
                
            }
        }
        
    }
}

extension CreateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension CreateViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if createdView.flashCardDetailOne.text == placeHolder {
            createdView.flashCardDetailOne.text = ""
            createdView.flashCardDetailOne.textColor = .black
        }
        if createdView.flashCardDetailTwo.text == placeHolder {
            createdView.flashCardDetailTwo.text = ""
            createdView.flashCardDetailTwo.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            if textView == createdView.flashCardDetailOne || textView == createdView.flashCardDetailTwo {
                if textView == createdView.flashCardDetailOne {
                    textView.textColor = .systemGray2
                    textView.text = placeHolder
                } else if textView == createdView.flashCardDetailTwo {
                    textView.textColor = .systemGray2
                    textView.text = placeHolder
                }
            }
        }
    }
    
}
extension CreateViewController: DataPersistenceDelegate {
    
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
    }
}
