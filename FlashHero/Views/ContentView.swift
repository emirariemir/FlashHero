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
    @State private var showCardsSheet = false
    
    // Dummy data for the list
    let dummyFolders = [
        ("Biology Study Set", "Biology"),
        ("Spanish Vocabulary", "Languages"),
        ("Math Formulas", "Mathematics"),
        ("History Notes", "History"),
        ("Chemistry Basics", "Science"),
        ("Programming Terms", "Computer Science")
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Main content
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("FlashHero")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding()
                    
                    // List of folders
                    if dummyFolders.isEmpty {
                        // Empty state
                        VStack(spacing: 20) {
                            Image(systemName: "tray")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                            Text("No flashcard sets yet")
                                .font(.title3)
                                .foregroundColor(.secondary)
                            Text("Tap the + button to create your first set")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxHeight: .infinity)
                    } else {
                        ScrollView {
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 16) {
                                ForEach(dummyFolders, id: \.0) { folder in
                                    FolderCard(title: folder.0, subtitle: folder.1)
                                }
                            }
                            .padding()
                        }
                    }
                }
                
                // Floating Action Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        PhotosPicker(selection: $viewModel.pickerItem, matching: .images) {
                            Image(systemName: "plus")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(
                                    Circle()
                                        .fill(Color.blue)
                                        .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                                )
                        }
                        .padding(.trailing, 24)
                        .padding(.bottom, 24)
                    }
                }
                
                // Loading overlay
                if viewModel.isRecognizingText {
                    ZStack {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                        
                        VStack(spacing: 16) {
                            ProgressView()
                                .scaleEffect(1.2)
                            Text("Recognizing text...")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding(32)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(.systemBackground))
                        )
                    }
                }
            }
            .navigationBarHidden(true)
            .onChange(of: viewModel.pickerItem) {
                viewModel.handlePickerItemChange()
            }
            .onChange(of: viewModel.flashcards) {
                if !viewModel.flashcards.isEmpty {
                    showCardsSheet = true
                }
            }
            .sheet(isPresented: $showCardsSheet) {
                CardsView(flashcards: viewModel.flashcards)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

// Folder Card Component
struct FolderCard: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: "folder.fill")
                .font(.system(size: 40))
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 140)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
        )
    }
}

#Preview {
    ContentView()
}
