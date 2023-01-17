//
//  DataController.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/05.
//

import CoreData

final class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "BookmarkedVocaModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
#if DEBUG
                print("\(error.localizedDescription)")
#endif
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
#if DEBUG
            print("\(error.localizedDescription)")
#endif
        }
    }
    
    func addVoca(word: String, definition: String, pronunciation: String, context: NSManagedObjectContext) {
        let voca = BookmarkedVoca(context: context)
        voca.id = UUID()
        voca.word = word
        voca.definition = definition
        voca.pronunciation = pronunciation
        
        save(context: context)
    }
}
