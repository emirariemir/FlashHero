//
//  CardsView.swift
//  FlashHero
//
//  Created by Emir Arı on 5.11.2025.
//

import SwiftUI

struct CardsView: View {
    let flashcards: [Flashcard]

    var body: some View {
        TabView {
            ForEach(flashcards) { card in
                CardView(
                    title: card.concept,
                    description: card.definition
                )
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    CardsView(flashcards: [
        Flashcard(concept: "Conditional Probability",
                  definition: "The probability of A given B, written as P(A|B)."),
        Flashcard(concept: "Bayes’ Rule",
                  definition: "Relates conditional probabilities: P(A|B) = P(B|A) * P(A) / P(B)."),
        Flashcard(concept: "Naive Bayes",
                  definition: "A classifier assuming features are independent given the class.")
    ])
}
