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
    
    //TODO: Data Persistence and populate myFlashcards with it
    private var myFlashCards = "" {
        didSet{
            cardsView.collectionView.reloadData()
            if myFlashCards.isEmpty { //we added the empty state in the next line
                //setup our empty view on the collectionView
                cardsView.collectionView.backgroundView = EmptyView(title: "Saved FlashCards", message: "There are no currently saved flashcards. Start by creating your own custom flashcards or search for existing flashcards by selecting one the tabs on the bottom of the screen")
            } else {
                //remove emptyView from collectionView background view, background view is just a collection set up but it sets the state of the collection view
                cardsView.collectionView.backgroundView = nil
            }
        }
    }
    
    
    override func loadView() {
        view = cardsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        cardsView.collectionView.register(CardsCollectionViewCell.self, forCellWithReuseIdentifier: "cardsCollectionViewCell")
        
    }
    
    //TODO: Create a fetchFlashCards func & Delegate Extension!!
    
    
}

extension CardsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
        //TODO: return the count of this
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardsCollectionViewCell", for: indexPath) as? CardsCollectionViewCell else {
            fatalError("Could not downcast to CardsCollectionViewCell" )}
        //TODO: Make sure this works once model is done
        //let myFlashCards = myFlashCards[indexPath.row]
        cell.backgroundColor = .systemPink
        //TODO: Configure cell func goes here once created, Finish step 4 of delegate here and call it
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
    
    //TODO: Not sure if you need to segue to another VC look at SavedArticleVC didSelectItemAt
}
