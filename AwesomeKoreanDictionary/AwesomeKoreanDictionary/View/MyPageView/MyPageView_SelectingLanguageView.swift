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
    
    @State private var selectedLanguage: String = "English"
    @State private var showingOptions: Bool = false
    
    var body: some View {
        
        var languages: [String] = ["Korean", "English", "Chinese", "Japanese"]
        
        
        VStack{
            List{
                Text("현재 설정된 언어")
                Text(selectedLanguage)
                    .padding(.horizontal)
                
                
                Text("언어 선택")
                ForEach(languages, id: \.self){ listString in
                    Text("\(listString)")
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
