//
//  ListCell.swift
//  AwesomeKoreanDictionary
//
//  Created by TAEHYOUNG KIM on 2023/01/05.
//

import SwiftUI

struct ListCell: View {
    var vocabulary: Vocabulary
    @State var selection: String = "ENG"
    var languages = ["KOR", "ENG", "CHN", "JPN"]
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // 이름
            HStack {
                VStack(alignment: .leading) {
                    Text(vocabulary.word)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(vocabulary.pronunciation)
                        .font(.title3)
                }
                Spacer()
               
                Picker(selection: $selection) {
                    ForEach(languages, id: \.self) { lang in
                        Text(lang)
                    }
                } label: {
                    Text("언어 선택")
                }

                
                
                Button {
                    print("북마크 버튼")
                } label: {
                    Image(systemName: "bookmark.fill")
                }
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
                    ForEach(vocabulary.example, id: \.self) { example in
                        
                        Text("• \(example)")
                            .italic()
                    }
                }
            }
            
            
            // 사용자 이름 / 날짜
            HStack {
                Text("from: \(vocabulary.creatorId)")
                    .fontWeight(.bold)
                Spacer()
                //                Text("업로드 날짜")
            }
            
            // 좋아요 버튼
            HStack(spacing: 20) {
                Button {
                    print("좋아요")
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "hand.thumbsup.fill")
                        Text("\(vocabulary.likes)")
                    }
                }
                Button {
                    print("싫어요")
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "hand.thumbsdown.fill")
                        Text("\(vocabulary.dislikes)")
                    }
                }
                
                Spacer()
                
                Button {
                    print("공유")
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .padding(20)
        .frame(width: 365)
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell(vocabulary: dictionary[0])
    }
}