//
//  MyPage_SelectingLanguageView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

import SwiftUI

enum Languages: String, CaseIterable{
    case korean = "Korean"
    case english = "English"
    case japanese = "Japanese"
    case chinese = "Chinese"
    
    func getLanguageCode() -> String{
        switch self {
        case .korean:
            return "kr"
        case .english:
            return "en"
        case .japanese:
            return "jp"
        case .chinese:
            return "ch"
        }
    }
}

struct MyPageView_SelectingLanguageView: View {
    
    @State private var defaultLanguage: String = "English"
    @State private var selectedLanguage: String?
    @State private var showingOptions: Bool = false
    
    var body: some View {
        
        let languages: [String] = ["Korean", "English", "Chinese", "Japanese"]
        
        VStack{
            Text("현재 설정된 언어")
            Text(defaultLanguage)
                .padding(.horizontal)
            Text("언어 선택")
            
            List(languages, id: \.self, selection: $selectedLanguage) { language in
                Button {
                    self.selectedLanguage = language
                    showingOptions.toggle()
                } label: {
                    Text("\(language)")
                }.buttonStyle(.plain)
                    .confirmationDialog("Select a language", isPresented: $showingOptions, titleVisibility: .visible) {
                        Button(selectedLanguage ?? "") {
                            defaultLanguage = selectedLanguage ?? ""
                        }
                        
                        Button(defaultLanguage) {
                            defaultLanguage = defaultLanguage
                        } // 여기까지가 .confirmation 한 덩어리
                    }
                    .padding(.horizontal)
                
            }.listStyle(.plain) // 리스트 끝
        }
    }
}


struct MyPage_SelectingLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView_SelectingLanguageView()
    }
}
