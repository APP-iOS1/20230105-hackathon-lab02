//
//  WaitingApproveCell.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/06.
//

import SwiftUI

struct WaitingApproveCell: View {
    
    @EnvironmentObject var vocabularyNetworkManager: VocabularyNetworkManager
    var vocabulary: Vocabulary
    
    @State var selection: String = ""
    @State var sharedSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // 단어의 이름
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(vocabulary.word)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                Spacer()
            }
            
            // 내용
            VStack(alignment: .leading, spacing: 5) {
                Text("Definition")
                    .foregroundColor(.secondary)
                Text(vocabulary.definition)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Example")
                    .foregroundColor(.secondary)
                VStack(alignment: .leading, spacing: 10) {
                    Text("• \(vocabulary.example)")
                        .italic()
//                    ForEach(vocabulary.example, id: \.self) { example in
//                    }
                }
            }
            
            
            // 사용자 이름 / 날짜
            HStack {
                
                Text("\(vocabulary.creatorId)")
                Spacer()
                
                if vocabulary.isApproved == false {
                    Button {
                    Task{
                        await vocabularyNetworkManager.updateVocaApproved(voca: vocabulary)
                        await vocabularyNetworkManager.requestVocabularyList()
                    }
                    
                } label: {
                    Text("승인하기")
                }
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.black)))
                .foregroundColor(.white)
                }
               
                //                Text("업로드 날짜")
            }
            
 
        }
        .foregroundColor(.black)
        .padding(20)
        .frame(width: 365)
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct WaitingApproveCell_Previews: PreviewProvider {
    static var previews: some View {
        WaitingApproveCell(vocabulary: dictionary[0])
    }
}
