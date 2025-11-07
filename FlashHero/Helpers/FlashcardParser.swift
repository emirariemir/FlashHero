//
//  FlashcardParser.swift
//  FlashHero
//
//  Created by Emir Arı on 7.11.2025.
//

import Foundation

class FlashcardParser {
    static func parse(jsonString: String) -> Flashcards? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Failed to convert string to data")
            return nil
        }
        
        let decoder = JSONDecoder()
        do {
            let flashcards = try decoder.decode(Flashcards.self, from: jsonData)
            return flashcards
        } catch {
            print("Failed to decode JSON: \(error)")
            return nil
        }
    }
}
