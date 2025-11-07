//
//  FlashcardJsonScheme.swift
//  FlashHero
//
//  Created by Emir Arı on 7.11.2025.
//

import Foundation
import OpenAI

struct FlashcardJsonScheme: JSONSchemaConvertible {
    let concept: String
    let definition: String
    
    static let example: FlashcardJsonScheme = {
        .init(
            concept: "Model-View-ViewModel (MVVM)",
            definition: "Model-View-ViewModel (MVVM) is an architectural pattern that separates a software application's user interface (UI) from its business logic, promoting modularity and testability."
        )
    }()
}
