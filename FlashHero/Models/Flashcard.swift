//
//  Flashcard.swift
//  FlashHero
//
//  Created by Emir Arı on 7.11.2025.
//

import Foundation

struct Flashcard: Codable, Identifiable {
    let concept: String
    let definition: String
    
    var id: String { concept }
}
