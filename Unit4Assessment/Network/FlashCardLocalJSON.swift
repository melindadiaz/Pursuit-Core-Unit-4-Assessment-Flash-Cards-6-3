//
//  FlashCardLocalJSON.swift
//  Unit4Assessment
//
//  Created by Melinda Diaz on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation
//This is a local JSON since the mock API does not work
//MARK: Make sure you need this there is anotherOne in the Model which one is better??!!

public enum AppleServiceError: Error {
  case resourcePathDoesNotExist
  case contentsNotFound
  case decodingError(Error)
}

final class FlashCardsServices {
  public static func fetchCards() throws -> [FlashCards] {
    guard let path = Bundle.main.path(forResource: "flashCards", ofType: "json") else {
      throw AppleServiceError.resourcePathDoesNotExist
    }
    guard let json = FileManager.default.contents(atPath: path) else {
      throw AppleServiceError.contentsNotFound
    }
    do {
      let cards = try JSONDecoder().decode([FlashCards].self, from: json)
      return cards
    } catch {
      throw AppleServiceError.decodingError(error)
    }
  }

}

