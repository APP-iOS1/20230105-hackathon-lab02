//
//  ListCell.swift
//  AwesomeKoreanDictionary
//
//  Created by TAEHYOUNG KIM on 2023/01/05.
//

import SwiftUI

struct ListCell: View {
    @State private var isLike: Bool = false
    @State private var isDislike: Bool = false
    @State private var isBookmark: Bool = false
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
                        .padding(.bottom, -3)
                    Text(vocabulary.pronunciation)
                        .font(.title3)
                        .padding(.bottom, 5)
                }
                Spacer()
                
                Picker(selection: $selection) {
                    ForEach(languages, id: \.self) { lang in
                        Text(lang)
                    }
                } label: {
                    Text("언어 선택")
                    
                }
                .frame(height: 30)
                .tint(.black)
                
                Button {
                    print("북마크 버튼")
                    isBookmark.toggle()
                } label: {
                    Image(systemName: isBookmark ? "bookmark.fill" : "bookmark")
                        .foregroundColor(Color.mint)
                        .font(.title2)
                        .padding(.trailing, -5)
                }
            }
            
            // 내용
            VStack(alignment: .leading, spacing: 5) {
                Text("Definition")
                    .foregroundColor(.secondary)
                    
                Text(vocabulary.definition)
                    .lineSpacing(7)
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
            .padding(.bottom, 10)
            
            
            // 사용자 이름 / 날짜
            HStack {
                Text("by \(vocabulary.creatorId)")
                    .fontWeight(.bold)
                Spacer()
                //                Text("업로드 날짜")
            }
            
            
            Divider().padding(.vertical,-1)
            
            // 좋아요 버튼
            HStack(spacing: 17) {
                Button {
                    print("좋아요")
                    isLike.toggle()
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: isLike ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .font(.title2)
                            .foregroundColor(.mint)
                        Text("\(vocabulary.likes)")
                    }
                }
                Button {
                    print("싫어요")
                    isDislike.toggle()
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: isDislike ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                            .font(.title2)
                            .foregroundColor(.mint)
                        Text("\(vocabulary.dislikes)")
                    }
                }
                
                Spacer()
                
                Button {
                    print("공유")
                } label: {
                    ShareLink(item: vocabulary.word) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title2)
                    }
                }
            }
            .padding(.top, -5)
            .onChange(of: isLike) { val in
              if val { isDislike = false }
            }
            .onChange(of: isDislike) { val in
              if val { isLike = false }
            }
        }
        .foregroundColor(.black)
        .padding(35)
        .frame(width: 360)
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell(vocabulary: dictionary[0])
    }
}
