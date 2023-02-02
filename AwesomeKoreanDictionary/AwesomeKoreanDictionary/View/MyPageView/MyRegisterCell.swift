//
//  MyPageView_MyRegisterView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

//
//  ListCell.swift
//  AwesomeKoreanDictionary
//
//  Created by TAEHYOUNG KIM on 2023/01/05.
//

import SwiftUI

struct MyRegisterCell: View {
    var vocabulary: Vocabulary
    var languages = ["KOR", "ENG", "CHN", "JPN"]
    
    @State var selection: String = ""
    @State var sharedSheet: Bool = false
    
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
                Text("승인여부 \(vocabulary.isApproved.description)")
                    .fontWeight(.bold)
                Spacer()
            }
 
        }
        .foregroundColor(.black)
        .padding(20)
        .frame(width: 365)
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct MyRegisterCell_Previews: PreviewProvider {
    static var previews: some View {
        MyRegisterCell(vocabulary: dictionary[0])
    }
}

