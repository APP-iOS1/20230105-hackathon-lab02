//
//  SearchView.swift
//  AwesomeKoreanDictionary
//
//  Created by TAEHYOUNG KIM on 2023/01/05.
//

import SwiftUI



struct SearchView: View {
    @State var searchText: String = ""
    var body: some View {
        Text("검색텍스트: \(searchText)")
            .searchable(text: $searchText)
        ForEach(searchResults) { result in
            Text(result.word)
        }
        
    }
    
    var searchResults: [Vocabulary] {
            if searchText.isEmpty {
                return []
            } else {
                return dictionary.filter { $0.word.contains(searchText) }
            }
        }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchView()
        }
    }
}
