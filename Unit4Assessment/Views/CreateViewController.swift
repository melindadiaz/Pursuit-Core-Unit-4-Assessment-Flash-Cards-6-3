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

    public var createFlashcards: FlashCards?
    public var dataPersistance: DataPersistence<FlashCards>!
    private let createdView = CreateView()
    
    override func loadView() {
        view = createdView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        createdView.flashCardAnswer.delegate = self
        createdView.flashCardDetailOne.delegate = self
        createdView.flashCardDetailTwo.delegate = self
        navigationItem.title = "Create Custom Flashcards"
          navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveCreatedFlashCardButtonPressed(_:)))
    }
    
    @objc func saveCreatedFlashCardButtonPressed(_ sender: UIBarButtonItem) {
           guard let flashCard = createFlashcards else { return }
           do {
            try dataPersistance.createItem(flashCard)
            showAlert(title: "Saved", message: "You successfully saved your custom FlashCard! Find this in your FlashCard tab below")
           } catch {
               print("error saving flashCard: \(flashCard)")
           }
       }

}

extension CreateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //TODO: Should I put data persistence here??
        //Lets Hope this gets rid of the keyboard
        textField.resignFirstResponder()
    }
}


