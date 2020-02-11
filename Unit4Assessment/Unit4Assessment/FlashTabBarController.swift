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
    
    //TODO: Put an instance of data persistence
    
    private lazy var cardsVC: CardsViewController = {
        let vc = CardsViewController()
        vc.tabBarItem = UITabBarItem(title: "FlashCards", image: UIImage(systemName: "doc.text"), tag: 0)
        //TODO: Add Data Persistence
        return vc
    }()
    
    private lazy var createVC: CreateViewController = {
        let vc = CreateViewController()
        vc.tabBarItem = UITabBarItem(title: "Create New", image: UIImage(systemName: "square.and.pencil"), tag: 1)
        //TODO: Add Data Persistence and custom delegate
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
