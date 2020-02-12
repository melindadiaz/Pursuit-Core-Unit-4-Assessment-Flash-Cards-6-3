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

    //TODO: CustomDelegate here!!
    public var dataPersistence: DataPersistence<FlashCards>!
    public var createFlashcards: FlashCards?
   
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
    
    private func customFlashCardRequirements() {
        if ((createdView.flashCardAnswer.text) == nil) && ((createdView.flashCardDetailOne.text) == nil) && createdView.flashCardDetailTwo.text?.isEmpty == true {
            showAlert(title: "Not Successful", message: "You need to fill all fields in order to create a custom flash card.")
        } else {
    }
    }
    //TODO: Fix this barButton problem
    @objc func saveCreatedFlashCardButtonPressed(_ sender: UIBarButtonItem) {
//        guard let flashCard = createFlashcards else {
//            showAlert(title: "error", message: "Nothing worked")
//            return
//        }
//        try dataPersistence.createItem(flashCard){
//            throw
//             showAlert(title: "Added to Favorites", message: "You successfully added this to your favorites! You may now find this picture in your favorites tab")
//        }
//           do {
//            guard let flashCard = createFlashcards else { return }
//            print("it works")
//            //customFlashCardRequirements()
//            try dataPersistence.createItem(flashCard)
//            showAlert(title: "Saved", message: "You successfully saved your custom FlashCard! Find this in your FlashCard tab below")
//           } catch {
//               print("error saving flashCard")
//           }
//
     }
    
}

extension CreateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        //TODO: Should I put data persistence here??
        //Lets Hope this gets rid of the keyboard
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
   //Its listening if an item gets saved then this function gets calledd
      func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
          print("item was saved")
          
      }
    //its listening to changes in deletion
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was deleted, THIS IS FOR TEST PURPOSES ONLY")
    }
}
