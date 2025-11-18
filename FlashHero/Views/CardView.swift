//
//  CardView.swift
//  FlashHero
//
//  Created by Emir Arı on 5.11.2025.
//

import SwiftUI

struct CardView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
                .padding([.horizontal, .top])
            
            Divider()
            
            Spacer()
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding([.horizontal, .bottom])
            
            Spacer()
        }
        .frame(height: 245)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.white))
                .stroke(.secondary, style: .init(lineWidth: 1))
        )
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}

#Preview {
    CardView(
        title: "Sample Card",
        description: "This is a reusable card view that you can use for titles, summaries, or previews in your SwiftUI layouts."
    )
}

