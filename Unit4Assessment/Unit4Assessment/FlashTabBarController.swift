//
//  FlashTabBarController.swift
//  Unit4Assessment
//
//  Created by Melinda Diaz on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence


class FlashTabBarController: UITabBarController {
    
    private var dataPersistence = DataPersistence<Cards>(filename: "savedFlashCards.plist")
    
    private lazy var cardsVC: CardsViewController = {
        let vc = CardsViewController()
        vc.tabBarItem = UITabBarItem(title: "FlashCards", image: UIImage(systemName: "doc.text"), tag: 0)
        vc.dataPersistence = dataPersistence
        vc.dataPersistence.delegate = vc
        return vc
    }()
    
    private lazy var createVC: CreateViewController = {
        let vc = CreateViewController()
        
        vc.dataPersistence = dataPersistence
        vc.dataPersistence.delegate = vc
        vc.tabBarItem = UITabBarItem(title: "Create New", image: UIImage(systemName: "square.and.pencil"), tag: 1)
        return vc
    }()
    
    private lazy var searchCardsVC: SearchCardsViewController = {
        let vc = SearchCardsViewController()
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: cardsVC), UINavigationController(rootViewController:createVC), UINavigationController(rootViewController:searchCardsVC)]
        
    }
    
    
    
    
}
