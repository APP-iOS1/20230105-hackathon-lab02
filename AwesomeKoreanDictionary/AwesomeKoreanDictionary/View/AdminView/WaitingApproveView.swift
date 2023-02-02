//
//  WaitingApproveView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/06.
//

import SwiftUI
import FirebaseAuth

struct WaitingApproveView: View {
    @EnvironmentObject var vocabularyNetworkManager: VocabularyNetworkManager
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "737DFE"), Color(hex: "FFCAC9")]),
                           startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView {
                    
                    Spacer(minLength: 10)
                    
                    VStack(spacing: 15) {
                        ForEach(vocabularyNetworkManager.vocabularies, id: \.self) { vocabulary in
                            
                            if vocabulary.isApproved == false {
                                WaitingApproveCell(vocabulary: vocabulary)
                            }
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

struct WaitingApproveView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingApproveView().environmentObject(VocabularyNetworkManager())
    }
}
