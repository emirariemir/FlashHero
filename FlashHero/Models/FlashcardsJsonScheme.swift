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
                concept: "What problem does MVVM solve in app development?",
                definition: "MVVM separates the UI from business logic, making your code easier to test, scale, and maintain. The ViewModel exposes data the View can react to without knowing where it comes from."
            ),
            FlashcardJsonScheme(
                concept: "How does the Combine framework help you handle async events?",
                definition: "Combine lets you work with data streams over time using publishers and subscribers. It's especially useful for things like network calls, timers, or UI updates that depend on changing data."
            ),
            FlashcardJsonScheme(
                concept: "How does SwiftUI manage state across views?",
                definition: "By using property wrappers like @State for simple local state, @Binding for passing state, and @ObservedObject or @StateObject for external data models that trigger UI updates."
            ),
            FlashcardJsonScheme(
                concept: "What can I build with WidgetKit?",
                definition: "WidgetKit lets you create Home Screen widgets that show quick, glanceable information from your app — like crypto prices, to-dos, or step counts — without opening the app."
            ),
            FlashcardJsonScheme(
                concept: "Why is async/await better than completion handlers?",
                definition: "With async/await, your asynchronous code reads like synchronous code. It's easier to follow, avoids callback pyramids, and works seamlessly with tasks and structured concurrency."
            )
        ])
    }()
}
