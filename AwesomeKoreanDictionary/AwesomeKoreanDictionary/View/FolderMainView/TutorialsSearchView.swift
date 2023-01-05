//
//  TutorialsSearchView.swift
//  AwesomeKoreanDictionary
//
//  Created by TAEHYOUNG KIM on 2023/01/05.
//

import SwiftUI

var dictionary: [Vocabulary] = [
    Vocabulary(
        id: "1",
        word: "킹받네",
        pronunciation: "[ King-batne ]",
        definition: "'킹받네' is a new word that uses king as a prefix to emphasize 'get angry'. In one word, it means very angry.",
        example: [
            "Oh i failed the test. really 킹받네.",
            "Look at him pretending to be cute. It's really 킹받네.",
            "Oh i left my phone at home. fuckin 킹받네."
        ],
        likes: 150,
        dislikes: 10,
        creatorId: "덕이"
    ),
    Vocabulary(
        id: "2",
        word: "중꺾마",
        pronunciation: "[ Joongkkeokma  ]",
        definition: "'킹받네' is a new word that uses king as a prefix to emphasize 'get angry'. In one word, it means very angry.",
        example: [
            "아, 시험 떨어졌어. 진짜 킹받네.",
            "쟤 귀여운척 하는거 봐봐. 킹받네.",
            "아, 미친 핸드폰 두고 나왔어. 개킹받네."
        ],
        likes: 150,
        dislikes: 10,
        creatorId: "덕이"
    ),
    
]

struct TutorialsSearchView: View {
    
    @State var searchText = ""
    
    //    var datas = (0...100).map(String.init).map(SomeData.init)
    
    var filteredDatas: [Vocabulary] {
        if searchText.isEmpty {
            return []
        } else {
//            return dictionary.filter { $0.word.localizedStandardContains(searchText) }
            return dictionary.filter { $0.word.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            ForEach(filteredDatas) { data in
                ListCell(vocabulary: data)
            }
            .navigationTitle("Search Test")
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "검색 placholder..."
        )
        .onSubmit(of: .search) {
            print("검색 완료: \(searchText)")
        }
        .onChange(of: searchText) { newValue in
            // viewModel 사용 시 이곳에서 새로운 값 입력
            print("검색 입력: \(newValue)")
        }
    }
}



struct SomeData: Identifiable {
    var name: String
    var id: String { self.name }
}

struct TutorialsSearchView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialsSearchView()
    }
}
