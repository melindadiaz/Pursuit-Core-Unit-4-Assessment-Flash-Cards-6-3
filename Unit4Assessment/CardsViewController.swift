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
    public var dataPersistence: DataPersistence<FlashCards>!
    
    //TODO: See if Data Persistence works Test to see your didSet gets called
    private var myFlashCards = [FlashCards]() {
        didSet{
            cardsView.collectionView.reloadData()
            if myFlashCards.isEmpty {
                cardsView.collectionView.backgroundView = EmptyView(title: "Saved FlashCards", message: "There are no currently saved flashcards. Start by creating your own custom flashcards or search for existing flashcards by selecting one the tabs on the bottom of the screen")
            } else {
                cardsView.collectionView.backgroundView = nil
            }
        }
    }
    //TODO: Fix the search bar!!
//    var userQuery = "" {
//           didSet {
//            myFlashCards = FlashCards.getCards().filter{$0.cards.contains(userQuery)}
//               //songs = Song.loveSongs.filter{$0.name.lowercased().contains(userQuery.lowercased())}
//           }
//       }
    
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
        fetchSavedFlashCards()
    }
    
    private func fetchSavedFlashCards() {
        do {
            //CompilerError: Thread 1: Fatal error: Unexpectedly found nil while implicitly unwrapping an Optional value
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
        
        //TODO: Configure cell func goes here once created, Finish step 4 of delegate here and call it
      cell.configureCell(for: myFlashCard)
        cell.backgroundColor = .white
        //cell.delegate = self
        return cell
    }
}

extension CardsViewController: DataPersistenceDelegate {
   //Its listening if an item gets saved then this function gets calledd
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
    
    //TODO: Not sure if you need to segue to another VC
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let flashcards = myFlashCards[indexPath.row]
        let detailVC = FlashCardsDetailViewController()
        detailVC.myFlashCardRef = flashcards
        detailVC.dataPersistence = dataPersistence
        //segue
        navigationController?.pushViewController(detailVC, animated: true)
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
