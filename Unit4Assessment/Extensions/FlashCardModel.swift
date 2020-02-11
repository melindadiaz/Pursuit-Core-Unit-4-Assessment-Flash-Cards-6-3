//
//  FlashCardModel.swift
//  Unit4Assessment
//
//  Created by Melinda Diaz on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct FlashCards: Decodable & Equatable {
    let cards: [Cards]
}

struct Cards: Decodable & Equatable {
    let id: Int
    let cardTitle: String
    let facts: [Facts]
}
//TODO: Make sure this is the appropriate model
struct Facts: Decodable & Equatable {
    let factOne: String
    let factTwo: String
    
}
