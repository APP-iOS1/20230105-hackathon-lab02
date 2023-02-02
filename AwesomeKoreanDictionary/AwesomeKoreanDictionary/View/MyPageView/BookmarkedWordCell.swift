//
//  BookmarkedWordCell.swift
//  AwesomeKoreanDictionary
//
//  Created by 박제균 on 2023/01/15.
//

import SwiftUI

struct BookmarkedWordCell: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.word)]) var voca: FetchedResults<BookmarkedVoca>
    @State private var selection: String = "ko"
    
    let vocabulary: BookmarkedVoca
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .top) {
                
                VStack(alignment: .leading) {
                    Text(vocabulary.word!)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, -3)
                        .foregroundColor(Color(hex: "292929"))
                    Text(vocabulary.pronunciation!)
                        .font(.title3)
                        .padding(.bottom, -5)
                }
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("Definition")
                    .foregroundColor(.secondary)
                Text(vocabulary.definition!)
                    .lineSpacing(7)
            }
            .padding(.bottom, -10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Example")
                    .foregroundColor(.secondary)
                VStack(alignment: .leading, spacing: 10) {
                    Text(vocabulary.example ?? "There are no examples.")
                        .italic()
                }
            }
            
            
            Divider().padding(.vertical, -1)
            
            HStack(spacing: 17) {
                Button {
                    print("공유")
                } label: {
                    ShareLink(item: vocabulary.word!) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title2)
                    }
                }
                Button {
                    withAnimation {
                        managedObjContext.delete(vocabulary)
                    }
                    do {
                        try managedObjContext.save()
                    } catch {
                        print(error)
                    }
                } label: {
                    Image(systemName: "bookmark.fill")
                        .foregroundColor(Color(hex: "737DFE"))
                        .font(.title2)
                        .padding(.trailing, -5)
                }
            }
        }
        .foregroundColor(.black)
        .padding(10)
        .frame(width: 360)
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct BookmarkedWordCell_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkedWordCell(vocabulary: BookmarkedVoca())
    }
}
