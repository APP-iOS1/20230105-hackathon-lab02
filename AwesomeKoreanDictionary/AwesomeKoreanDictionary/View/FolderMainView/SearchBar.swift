//
//  SearchBar.swift
//  AwesomeKoreanDictionary
//
//  Created by TAEHYOUNG KIM on 2023/01/05.
//

import SwiftUI

var dictionary: [Vocabulary] = [
    Vocabulary(
        id: UUID().uuidString,
        word: "킹받네",
        pronunciation: "[ King-batne ]",
        definition: "'킹받다'는 '열 받다'를 강조하기 위해 킹(king·왕)을 접두어처럼 사용한 신조어다. 한 마디로 엄청 화났다는 뜻이다.",
        example: "아, 시험 떨어졌어. 진짜 킹받네.",
        likeArray: [],
        dislikeArray: [],
        creatorId: "덕이",
        isApproved: true
    ),
    Vocabulary(
        id: UUID().uuidString,
        word: "중꺾마",
        pronunciation: "[ Joongkkeokma ]",
        definition: "‘중요한 건 꺾이지 않는 마음’의 줄임말",
        example: "패배해도 괜찮아, 중요한 건 꺾이지 않는 마음이야.",
        likeArray: [],
        dislikeArray: [],
        creatorId: "종이",
        isApproved: true
    )
]

struct SearchBar: View {
    
    @Binding var searchText: String
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("Search", text: $searchText)
                    .foregroundColor(.primary)
                
                if !searchText.isEmpty {
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .frame(height:30)
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
        
//        .padding(.horizontal)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""))
    }
}
