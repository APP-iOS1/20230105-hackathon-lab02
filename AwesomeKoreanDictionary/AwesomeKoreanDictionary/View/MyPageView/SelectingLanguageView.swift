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

struct SelectingLanguageView: View {
    @AppStorage("selectedLanguage") private var selectedLanguage: String?
        
    private let languages = ["Korean", "English", "Japanese","Chinese"]
    
    @State private var defaultLanguage: String = "한국어"
    @State private var showingOptions: Bool = false
    
    var body: some View {

            VStack{
                List{
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
                        .confirmationDialog("해당 언어로 설정을 변경합니다. 껐다 키세요!", isPresented: $showingOptions, titleVisibility: .visible) {
                            Button(selectedLanguage ?? "") {
                                defaultLanguage = selectedLanguage ?? ""
                                UserDefaults.standard.set([defaultLanguage], forKey: "AppleLanguages")
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
