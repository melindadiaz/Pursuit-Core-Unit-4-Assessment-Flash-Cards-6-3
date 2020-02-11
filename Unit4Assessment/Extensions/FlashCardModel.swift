//
//  FlashCardModel.swift
//  Unit4Assessment
//
//  Created by Melinda Diaz on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct FlashCards: Codable & Equatable {
    let cards: [Cards]
}

struct Cards: Codable & Equatable {
    let id: String
    let quizTitle: String
    let cardTitle: String
    let facts: [Facts]
}
//TODO: Make sure this is the appropriate model
struct Facts: Codable & Equatable {
    let factOne: String
    let factTwo: String
    
}

//MARK: You may not need this
extension FlashCards {
    static func getCards() -> [FlashCards] {
        var flashcards = [FlashCards]()
        
        guard let fileURL = Bundle.main.url(forResource: "flashCards", withExtension: "json") else {
            fatalError("could not locate json file")
        }
        do {
            let data = try Data(contentsOf: fileURL)
            
            let flashcardData = try JSONDecoder().decode(FlashCards.self, from: data)
            flashcards = [flashcardData]
        } catch {
            fatalError("failed to load contents \(error)")
        }
        return flashcards
    }
}
