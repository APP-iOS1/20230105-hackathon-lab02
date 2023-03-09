//
//  WaitingApproveCell.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/06.
//

import SwiftUI

struct WaitingApproveCell: View {
    @EnvironmentObject var vocabularyNetworkManager: VocabularyNetworkManager
    @State var selection: String = ""
    @State var sharedSheet: Bool = false
    var vocabulary: Vocabulary
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(vocabulary.word)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, -3)
                        .foregroundColor(Color(hex: "292929"))
                    Text(vocabulary.pronunciation)
                        .font(.title3)
                        .padding(.bottom, -5)
                }
                Spacer()
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("정의")
                    .foregroundColor(.secondary)
                Text(vocabulary.definition)
                    .lineSpacing(7)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("예시")
                    .foregroundColor(.secondary)
                VStack(alignment: .leading, spacing: 10) {
                    Text("• \(vocabulary.example)")
                        .italic()
                }
            }
            HStack {
                Text("by \(vocabulary.creatorId)")
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "292929"))
                Spacer()
                
                if vocabulary.isApproved == false {
                    Button {
                    Task{
                        await vocabularyNetworkManager.updateVocaApproved(voca: vocabulary)
                        await vocabularyNetworkManager.requestVocabularyList()
                    }
                    
                } label: {
                    Text("승인하기")
                        .frame(width: 100, height: 25)
                }
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(hex: "737DFE")))
                
                .foregroundColor(.AKDWhite)
                }
            }
        }
        .foregroundColor(.AKDBlack)
        .padding(35)
        .frame(width: 365)
        .background(Color.AKDWhite)
        .cornerRadius(20)
    }
}

struct WaitingApproveCell_Previews: PreviewProvider {
    static var previews: some View {
        WaitingApproveCell(vocabulary: dictionary[0])
    }
}
