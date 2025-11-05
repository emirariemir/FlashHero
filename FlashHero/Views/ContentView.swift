//
//  ContentView.swift
//  FlashHero
//
//  Created by Emir Arı on 5.11.2025.
//

import SwiftUI
import PhotosUI
import Vision

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    PhotosPicker("Select photo", selection: $viewModel.pickerItem, matching: .images)
                    
                    viewModel.pickerImage?
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 300)
                    
                    if let recognizedText = viewModel.recognizedText {
                        Text(recognizedText)
                            .font(.footnote)
                    }
                }
                .onChange(of: viewModel.pickerItem) {
                    viewModel.handlePickerItemChange()
                }
                
                if viewModel.isRecognizingText {
                    Rectangle()
                        .fill()
                        .opacity(0.3)
                        .ignoresSafeArea()
                    
                    ProgressView()
                }
            }
            .navigationDestination(isPresented: $viewModel.isShowingCardView) {
                CardsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
