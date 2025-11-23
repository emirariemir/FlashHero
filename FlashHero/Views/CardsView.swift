//
//  CardsView.swift
//  FlashHero
//
//  Created by Emir Arı on 5.11.2025.
//

import SwiftUI

struct CardsView: View {
    let flashcards: [Flashcard]
    @Environment(\.dismiss) var dismiss
    @State private var showingSaveAlert = false
    @State private var isSaved = false
    
    let viewModel = CardsViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Cards TabView
                TabView {
                    ForEach(flashcards) { card in
                        CardView(
                            title: card.concept,
                            description: card.definition
                        )
                        .padding()
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                // Save Button
                if !isSaved {
                    Button(action: {
                        viewModel.saveCardsToCoreData(flashcards)
                        isSaved = true
                        showingSaveAlert = true
                        
                        // Auto dismiss after 1.5 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            dismiss()
                        }
                    }) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title3)
                            Text("Save Cards")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                    }
                    .padding()
                } else {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("Cards Saved!")
                            .foregroundColor(.green)
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(12)
                    .padding()
                }
            }
            .navigationTitle("Flashcards")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
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
