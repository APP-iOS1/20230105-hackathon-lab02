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
    @Environment(\.editMode) var editMode
    @FetchRequest(sortDescriptors: [SortDescriptor(\.word)]) var vocabularies: FetchedResults<BookmarkedVoca>
    
    @State private  var selection: String = "KOR"
    @State private var isBookmark: Bool = false

    let languages = ["KOR", "ENG", "CHN", "JPN"]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "737DFE"), Color(hex: "FFCAC9")]),
                           startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Text("북마크한 단어들")
                
                if !vocabularies.isEmpty {
                    
                    List {
                        ForEach(vocabularies) { voca in
                            BookmarkedWordCell(vocabulary: voca)
                        }
                        
                    }
                    .listStyle(.plain)
                } else {
                    Text("찜한 단어가 없습니다!")
                }
            }
        }
        
    }
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let item = vocabularies[index]
            managedObjContext.delete(item)
        }
        
        do {
            try managedObjContext.save()
        } catch {
            print(error)
        }
    }
    
    //     Deletes voca at the current offset
    private func deleteVoca(offsets: IndexSet) {
        withAnimation {
//            if let index = voca.firstIndex(where: { $0.word == voca.word }) {
//                managedObjContext.delete(voca[index])
//            }
            offsets.map { vocabularies[$0] }
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
