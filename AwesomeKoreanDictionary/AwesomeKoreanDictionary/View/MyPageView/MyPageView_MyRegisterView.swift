//
//  SwiftUIView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/06.
//

import SwiftUI
import FirebaseAuth

struct MyPageView_MyRegisterView: View {
    @EnvironmentObject var vocabularyNetworkManager: VocabularyNetworkManager
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "737DFE"), Color(hex: "FFCAC9")]),
                           startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                
                Spacer(minLength: 10)
                
                VStack(spacing: 15) {
                    ForEach(vocabularyNetworkManager.vocabularies, id: \.self) { vocabulary in
                        
                        if Auth.auth().currentUser?.uid == vocabulary.creatorId {
                            MyPageView_MyRegisterCell(vocabulary: vocabulary)
                        }
                    }
                    
                }
            }
        }
        .task {
            await vocabularyNetworkManager.requestVocabularyList()
        }
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView_MyRegisterView()
    }
}
