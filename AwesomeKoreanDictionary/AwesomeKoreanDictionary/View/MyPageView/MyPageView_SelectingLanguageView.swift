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
    
    @State private var defaultLanguage: String = "영어"
    @State private var selectedLanguage: String?
    @State private var showingOptions: Bool = false
    
    var body: some View {
        
        let languages: [String] = ["한국어", "영어", "중국어", "일본어"]

            VStack{
                List{
                    Text("현재 설정된 언어")
                        .font(.title3)
                        .padding(.top)
                    Text(defaultLanguage)
                        .padding(.horizontal)
                    
                    Text("언어 선택")
                        .font(.title3)
                        .padding(.top)
                    
                    ForEach(languages, id: \.self) { language in
                        
                        Button {
                            self.selectedLanguage = language
                            showingOptions.toggle()
                        } label: {
                            Text("\(language)")
                        }
                        .confirmationDialog("해당 언어로 설정을 변경합니다.", isPresented: $showingOptions, titleVisibility: .visible) {
                            Button(selectedLanguage ?? "") {
                                defaultLanguage = selectedLanguage ?? ""
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                }.listStyle(.inset)
            }
    }
}


struct MyPage_SelectingLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView_SelectingLanguageView()
    }
}
