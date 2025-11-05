//
//  CardsView.swift
//  FlashHero
//
//  Created by Emir Arı on 5.11.2025.
//

import SwiftUI

struct CardsView: View {
    var body: some View {
        TabView {
            CardView(
                title: "Welcome",
                description: "This is the first card. You can use it to show some introductory content."
            )
            
            CardView(
                title: "Discover",
                description: "This second card can highlight a feature or some key information."
            )
            
            CardView(
                title: "Get Started",
                description: "This last card can guide users to begin exploring your app."
            )
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    CardsView()
}
