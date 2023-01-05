//
//  SearchView.swift
//  AwesomeKoreanDictionary
//
//  Created by TAEHYOUNG KIM on 2023/01/05.
//

import SwiftUI


struct SearchView: View {
    
    @State var searchText = ""
    
    var filteredVoca: [Vocabulary] {
        if searchText.isEmpty {
            return []
        } else {
            //            return dictionary.filter { $0.word.localizedStandardContains(searchText) }
            return dictionary.filter { $0.word.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            ForEach(filteredVoca) { voca in
                ListCell(vocabulary: voca)
            }
        }
        .searchable(
            text: $searchText, placement: .navigationBarDrawer(displayMode: .always)
        )
        .onSubmit(of: .search) {
            print("검색 완료: \(searchText)")
        }
        .onChange(of: searchText) { newValue in
            print("검색 입력: \(newValue)")
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
            SearchView()
    }
}
