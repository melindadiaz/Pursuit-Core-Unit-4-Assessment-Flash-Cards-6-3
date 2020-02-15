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
    
    public var dataPersistence: DataPersistence<Cards>!
    private let searchView = SearchCardsView()
    private var flashCardSearch = [Cards](){
        didSet {
            DispatchQueue.main.async {
                self.searchView.collectionView.reloadData()
            }
        }
    }
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
        fetchStuff()
        navigationItem.title = "Premade Flash Cards"
    }
    
    
    private func fetchStuff() {
        FlashCardsAPIClient.fetchFlashCards { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "Cannot load premade flash cards")
                }
            case .success(let cards):
                self?.flashCardSearch = cards
            }
        }
    }
}

extension SearchCardsViewController: DataPersistenceDelegate {
    
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
    }
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
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
        return flashCardSearch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCollectionCell", for: indexPath) as? SearchCollectionCell else {
            fatalError("Could not downcast to SearchCollectionCell" )}
        let myFlashCard = flashCardSearch[indexPath.row]
        cell.configureCell(for: myFlashCard)
        cell.backgroundColor = .white
        cell.delegate = self
        return cell
    }
}

extension SearchCardsViewController: UISearchBarDelegate {
    //TODO: Does not search anything
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
}

extension SearchCardsViewController: SavedFlashCardCellDelegate {
    func didSelectMoreButton(_ savedFlashCards: SearchCollectionCell, flashCards: Cards) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Save", style: .default) { alertAction in
            self.saveFlashCard(flashCards: flashCards)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        present(alertController, animated: true)
    }
    
    private func saveFlashCard(flashCards: Cards) {
        guard let index = flashCardSearch.firstIndex(of: flashCards) else {
            return
        }
        do {
            try dataPersistence.createItem(flashCards)
            DispatchQueue.main.async {
                self.showAlert(title: "Flash Card Saved", message: "You successfully added this to your flash card collection! You may now find this flash card in your FlashCards tab.")
            }
        } catch {
        }
    }
}

