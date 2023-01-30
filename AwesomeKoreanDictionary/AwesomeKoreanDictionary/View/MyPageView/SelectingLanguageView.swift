//
//  MyPage_SelectingLanguageView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

import SwiftUI

enum Languages: String, CaseIterable{
    case korean = "한국어"
    case english = "영어"
    case japanese = "일본어"
    case chinese = "중국어"
    
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

struct SelectingLanguageView: View {
    @AppStorage("selectedLanguage") private var selectedLanguage: String?
        
    private let languageDict: [String: String] = ["한국어": "Korean", "영어": "English", "일본어": "Japanese", "중국어": "Chinese"]
    
    @State private var defaultLanguage: String = "한국어"
    @State private var showingOptions: Bool = false
    
    var body: some View {

            VStack{
                List{
                    Text("언어 선택")
                        .font(.title3)
                        .padding(.top)
                    
                    ForEach(Array(languageDict.keys), id: \.self) { language in
                        
                        Button {
                            //요부분 수정에 한국어 들어가는중
                            self.selectedLanguage = languageDict[language]
                            showingOptions.toggle()
                        } label: {
                            Text(LocalizedStringKey(language))
                        }
                        .confirmationDialog("언어설정을 바꾼뒤 앱을 재가동해야합니다. 선택된 언어로 바꾸시겠습니까?", isPresented: $showingOptions, titleVisibility: .visible) {
                            Button("변경") {
                                defaultLanguage = selectedLanguage ?? ""
                                UserDefaults.standard.set([defaultLanguage], forKey: "AppleLanguages")
                                //이코드 누가 씀...? 질문질문
                                UIApplication.shared.requestSceneSessionActivation(nil, userActivity: nil, options: nil, errorHandler: nil)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                }.listStyle(.inset)
            }
    }
}


struct SelectingLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        SelectingLanguageView()
    }
}
