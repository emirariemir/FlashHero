//
//  CardsViewModel.swift
//  FlashHero
//
//  Created by Emir Arı on 20.11.2025.
//

import CoreData

struct CardsViewModel {
    let pc = PersistenceController.shared
    
    func saveCardsToCoreData(_ flashcards: [Flashcard]) {
        let dummyFolder = Folder(context: pc.container.viewContext)
        dummyFolder.name = "Dummy folder"
        dummyFolder.date = Date()
        
        for flashcard in flashcards {
            let newCard = Card(context: pc.container.viewContext)
            newCard.concept = flashcard.concept
            newCard.definition = flashcard.definition
            newCard.folder = dummyFolder
        }
        
        pc.save()
    }
}
