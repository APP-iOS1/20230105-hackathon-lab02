//
//  MyPageView_MyBookmarkView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/06.
//

import SwiftUI
import CoreData

struct MyPageView_MyBookmarkView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.word)]) var voca: FetchedResults<BookmarkedVoca>
    
    var body: some View {
        VStack{
            Text("북마크한 단어들")
            List {
                ForEach(voca) { voca in
                    Text("\(voca.word!)")
                    Text("\(voca.definition!)")
                }
                .onDelete(perform: deleteVoca)
            }.listStyle(.plain)
        }
        
    }
//     Deletes voca at the current offset
    private func deleteVoca(offsets: IndexSet) {
        withAnimation {
            offsets.map { voca[$0] }
            .forEach(managedObjContext.delete)

            // Saves to our database
            DataController().save(context: managedObjContext)
        }
    }
}

struct MyPageView_MyBookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView_MyBookmarkView()
    }
}
