//
//  ApprovedView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/06.
//

import SwiftUI

struct ApprovedView: View {
    @EnvironmentObject var vocabularyNetworkManager: VocabularyNetworkManager
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "737DFE"), Color(hex: "FFCAC9")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView {
                    
                    Spacer(minLength: 10)
                    
                    VStack(spacing: 15) {
                        ForEach(vocabularyNetworkManager.vocabularies, id: \.self) { vocabulary in
                        
                        if vocabulary.isApproved == true {
                            WaitingApproveCell(vocabulary: vocabulary)
                        }
                    }
                    
                }
            }
            }
        .onAppear(){
            Task{
                await vocabularyNetworkManager.requestVocabularyList()
                /*파이어베이스에서 @Published var vocabularies: [Vocabulary] = [] 에 모든 정보를 저장한 뒤에
                 사용하는데, Request 하기 전까지는 빈 값. request를 함으로써 비로소 리스트에 정보가 저장되고,
                 우리는 이제 가져다 쓸 수 있다.*/
            }
        }
        }
        }
}

struct ApprovedView_Previews: PreviewProvider {
    static var previews: some View {
        ApprovedView().environmentObject(VocabularyNetworkManager())
    }
}
