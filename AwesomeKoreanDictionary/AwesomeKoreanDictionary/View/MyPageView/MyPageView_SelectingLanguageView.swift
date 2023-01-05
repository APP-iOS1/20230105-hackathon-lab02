//
//  MyPage_SelectingLanguageView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

import SwiftUI

struct MyPageView_SelectingLanguageView: View {
    
    @State private var selectedLanguage: String = "English"
    
    var body: some View {
        
        var languages: [String] = ["English(UK)","English(Australia",]
        
        
        VStack{
            List{
                Text("Current Languages")
                
                
                
                Text("s")
            }.listStyle(.plain)
        }
    }
}

struct MyPage_SelectingLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView_SelectingLanguageView()
    }
}
