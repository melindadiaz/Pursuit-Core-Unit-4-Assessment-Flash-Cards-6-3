//
//  SearchCardsViewController.swift
//  Unit4Assessment
//
//  Created by Melinda Diaz on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class SearchCardsViewController: UIViewController {

    public var dataPersistence: DataPersistence<FlashCards>!
    private let searchView = SearchCardsView()
    private var flashCardSearch: FlashCards?
    
    override func loadView() {
        view = searchView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.collectionView.register(SearchCollectionCell.self, forCellWithReuseIdentifier: "searchCollectionCell")
        searchView.searchBar.delegate = self
    }
    

}
//TODO: fix this
extension SearchCardsViewController: DataPersistenceDelegate {
    //Its listening if an item gets saved then this function gets called
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was saved")
        //if you want to see what you did here
        
    }
    //its listening to changes in deletion
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        
        print("item was deleted, THIS IS FOR TEST PURPOSES ONLY")
    }
}
extension SearchCardsViewController: UICollectionViewDelegateFlowLayout {
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

extension SearchCardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCollectionCell", for: indexPath) as? SearchCollectionCell else {
             fatalError("Could not downcast to SearchCollectionCell" )}
         //TODO: Make sure this works once model is done
         //let myFlashCard = flashCardSearch[indexPath.row]
         
         //TODO: Configure cell func goes here once created, Finish step 4 of delegate here and call it
        //cell.configureCell(for: myFlashCard)
         cell.backgroundColor = .white
         //cell.delegate = self
         return cell
    }
    
    
}

extension SearchCardsViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar, textDidChange searchText: String) {
      print("THIS IS JUST A TEST \(searchBar.searchTextField.text)")
      guard !searchText.isEmpty else {
          //if its empty we want to reload all the cards
        //TODO: Fix searchbar keyboard
          searchView.searchBar.resignFirstResponder()
       return
      }
  }

}

