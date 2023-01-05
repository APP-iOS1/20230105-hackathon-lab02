//
//  TestVIew.swift
//  AwesomeKoreanDictionary
//
//  Created by TAEHYOUNG KIM on 2023/01/05.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var vocabularyNetworkManager: VocabularyNetworkManager
    var body: some View {
        
        ForEach(dictionary) { voca in
            Button {
                Task {
                    await vocabularyNetworkManager.createVoca(voca: voca)
                }
            } label: {
                Text("\(voca.word) 서버에 올리기")
            }
        }
        

    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
            .environmentObject(VocabularyNetworkManager())
    }
}
