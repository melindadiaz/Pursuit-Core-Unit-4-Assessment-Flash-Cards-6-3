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
    
    
    override func loadView() {
        view = cardsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        cardsView.collectionView.register(CardsCollectionViewCell.self, forCellWithReuseIdentifier: "cardsCollectionViewCell")
        cardsView.collectionView.dataSource = self
        cardsView.collectionView.delegate = self
        fetchSavedFlashCards()
    }
    
    //TODO: Create a fetchFlashCards func & Delegate Extension!!
    private func fetchSavedFlashCards() {
        do {
            myFlashCards = try dataPersistence.loadItems() ?? FlashCards.getCards()
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
        //TODO: Make sure this works once model is done
        //let myFlashCard = FlashCards[indexPath.row]
        
        //TODO: Configure cell func goes here once created, Finish step 4 of delegate here and call it
       // cell.configureCell(for: myFlashCard)
        cell.backgroundColor = .white
        return cell
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
