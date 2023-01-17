//
//  MyPageView_MyBookmarkView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/06.
//

import SwiftUI
import CoreData

struct MyBookmarkView: View {
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
            
            ScrollView {
                Spacer(minLength: 10)
                
                VStack {
                    if !vocabularies.isEmpty {
                        ForEach(vocabularies) { voca in
                            BookmarkedWordCell(vocabulary: voca)
                        }
                    } else {
                        ZStack {
                            Text("북마크한 단어가 없습니다!")
                                .font(.title2)
                                .kerning(-1)
                                .padding(.top, 80)
                        }
                    }
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
    
    private func deleteVoca(offsets: IndexSet) {
        withAnimation {
            offsets.map { vocabularies[$0] }
                .forEach(managedObjContext.delete)
            
            DataController().save(context: managedObjContext)
        }
    }
}

struct MyBookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        MyBookmarkView()
    }
}
