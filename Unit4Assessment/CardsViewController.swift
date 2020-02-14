//
//  CardsViewController.swift
//  Unit4Assessment
//
//  Created by Melinda Diaz on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CardsViewController: UIViewController {
    
    private let cardsView = CardsView()
    
    //Step4: Instance of dataPersistence
    public var dataPersistence: DataPersistence<Cards>!
    
    //TODO: See if Data Persistence works Test to see your didSet gets called
    private var myFlashCards = [Cards]() {
        didSet{
            cardsView.collectionView.reloadData()
            if myFlashCards.isEmpty {
                cardsView.collectionView.backgroundView = EmptyView(title: "Saved FlashCards", message: "There are no currently saved flashcards. Start by creating your own custom flashcards or search for existing flashcards by selecting one the tabs on the bottom of the screen")
            } else {
                cardsView.collectionView.backgroundView = nil
            }
        }
    }
    
    var isSearchBarEmpty: Bool {
        return cardsView.searchBar.text?.isEmpty ?? true
    }
    
    
    override func loadView() {
        view = cardsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        cardsView.collectionView.register(CardsCollectionViewCell.self, forCellWithReuseIdentifier: "cardsCollectionViewCell")
        cardsView.collectionView.dataSource = self
        cardsView.collectionView.delegate = self
        cardsView.searchBar.delegate = self
        //this is showing changes and it will listen for the changes
        dataPersistence.delegate = self
        fetchSavedFlashCards()
    }
    
    private func fetchSavedFlashCards() {
        do {
            myFlashCards = try dataPersistence.loadItems()
        } catch {
            showAlert(title: "Error", message: "Could not load cards!")
            print("Cannot load flashcards \(error)")
        }
    }
}

extension CardsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myFlashCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardsCollectionViewCell", for: indexPath) as? CardsCollectionViewCell else {
            fatalError("Could not downcast to CardsCollectionViewCell" )}
        
        let myFlashCard = myFlashCards[indexPath.row]
        
        //TODO:Finish step 4 of delegate here and call it
        cell.configureCell(for: myFlashCard)
        cell.backgroundColor = .white
        //cell.delegate = self
        return cell
    }
}

extension CardsViewController: DataPersistenceDelegate {
    //Its listening if an item gets saved then this function gets called
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was saved")
        fetchSavedFlashCards()
    }
    //its listening to changes in deletion
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchSavedFlashCards()
        print("item was deleted, THIS IS FOR TEST PURPOSES ONLY")
    }
}

extension CardsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 10
        let itemHeight: CGFloat = maxSize.height * 0.3
        let numberOfItems: CGFloat = 2
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing)/numberOfItems
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension CardsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("THIS IS JUST A TEST \(searchBar.searchTextField.description)")
        guard !searchText.isEmpty else {
            fetchSavedFlashCards()
            return
        }
    }
}

extension CardsViewController: SavedFlashCardDelegate {
    func didSelectMoreButton(_ savedFlashCards: CardsCollectionViewCell, flashCards: Cards) {
         let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
               let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
               let deleteAction = UIAlertAction(title: "Delete?", style: .destructive) { alertAction in
                self.deleteFlashCard(flashCards: flashCards)
                   //write a delete Helper function
               }
               alertController.addAction(cancelAction)
               alertController.addAction(deleteAction)
               present(alertController, animated: true)
           }
    
    private func deleteFlashCard(flashCards: Cards) {
        guard let thisIndex = myFlashCards.firstIndex(of: flashCards) else {
            return
        }
        do {
            //deletes from documents directory
            try dataPersistence.deleteItem(at: thisIndex)
        } catch {
           
            print("error deleting flashCard: \(error) For TEST purposes only must delete after")
        }
    }
}
