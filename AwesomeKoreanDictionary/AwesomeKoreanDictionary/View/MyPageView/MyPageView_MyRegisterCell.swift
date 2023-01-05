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

struct MyPageView_MyRegisterCell: View {
    var vocabulary: Vocabulary
    var languages = ["KOR", "ENG", "CHN", "JPN"]
    
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
                Text("정의")
                    .foregroundColor(.secondary)
                Text(vocabulary.definition)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("예시")
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
                Text("승인여부 \(vocabulary.isApproved.description)")
                    .fontWeight(.bold)
                Spacer()
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

struct MyPageView_MyRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView_MyRegisterCell(vocabulary: dictionary[0])
    }
}

