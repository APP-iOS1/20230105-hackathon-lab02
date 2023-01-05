//
//  DataController.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/05.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "BookmarkedVocaModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully. WUHU!!!")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addVoca(word: String, definition: String, context: NSManagedObjectContext) {
        let voca = BookmarkedVoca(context: context)
        voca.id = UUID()
        voca.definition = definition
        
        save(context: context)
    }
    
    // Deletes food at the current offset
//    private func deleteVoca(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { voca[$0] }
//            .forEach(managedObjContext.delete)
//
//            // Saves to our database
//            DataController().save(context: managedObjContext)
//        }
//    }
}
