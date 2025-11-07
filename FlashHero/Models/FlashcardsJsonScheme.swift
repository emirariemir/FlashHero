//
//  FlashcardsJsonScheme.swift
//  FlashHero
//
//  Created by Emir Arı on 7.11.2025.
//

import Foundation
import OpenAI

struct FlashcardsJsonScheme: JSONSchemaConvertible {
    let flashcards: [FlashcardJsonScheme]
    
    static let example: FlashcardsJsonScheme = {
        .init(flashcards: [
            FlashcardJsonScheme(
                concept: "Model-View-ViewModel (MVVM)",
                definition: "Model-View-ViewModel (MVVM) is an architectural pattern that separates a software application's user interface (UI) from its business logic, promoting modularity and testability."
            ),
            FlashcardJsonScheme(
                concept: "Combine Framework",
                definition: "Combine is Apple’s reactive programming framework that processes asynchronous events over time using publishers and subscribers."
            ),
            FlashcardJsonScheme(
                concept: "SwiftUI State Management",
                definition: "SwiftUI uses property wrappers like @State, @Binding, and @ObservedObject to manage and synchronize UI state efficiently."
            ),
            FlashcardJsonScheme(
                concept: "WidgetKit",
                definition: "WidgetKit is a framework that allows developers to build home screen widgets for iOS, displaying glanceable and timely information from their apps."
            ),
            FlashcardJsonScheme(
                concept: "Concurrency with async/await",
                definition: "Swift’s async/await syntax allows developers to write asynchronous code that is readable and structured like synchronous code, improving clarity and safety."
            )
        ])
    }()
}
