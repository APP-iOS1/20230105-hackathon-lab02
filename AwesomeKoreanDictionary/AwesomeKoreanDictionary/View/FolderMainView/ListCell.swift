//
//  ListCell.swift
//  AwesomeKoreanDictionary
//
//  Created by TAEHYOUNG KIM on 2023/01/05.
//



import SwiftUI

struct ListCell: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @State private var isLike: Bool = false
    @State private var isDislike: Bool = false
    @State private var isBookmark: Bool = false
    var vocabulary: Vocabulary
    var languages = ["KOR", "ENG", "CHN", "JPN"]
    @EnvironmentObject var vocabularyNetworkManager: VocabularyNetworkManager
    @State var selection: String = "KOR"
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
                        .foregroundColor(Color(hex: "292929"))
                    Text(vocabulary.pronunciation)
                        .font(.title3)
                        .padding(.bottom, -5)
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
                    
                    //coreData에 저장
                    DataController().addVoca(word: vocabulary.word, definition: vocabulary.definition, context: managedObjContext)
                    
                    
                    
                } label: {
                    Image(systemName: isBookmark ? "bookmark.fill" : "bookmark")
                        .foregroundColor(Color(hex: "737DFE"))
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
            .padding(.bottom, -10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Example")
                    .foregroundColor(.secondary)
                VStack(alignment: .leading, spacing: 10) {
                    Text("• \(vocabulary.example)")
                        .italic()
//                    ForEach(vocabulary.example, id: \.self) { example in
//
//                        Text("• \(example)")
//                            .italic()
//                    }
                }
            }
          //  .padding(.bottom, 10)
            
            
            // 사용자 이름 / 날짜
            HStack {
                Text("by \(vocabulary.creatorId)")
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "292929"))
                Spacer()
                //                Text("업로드 날짜")
            }
            
            
            Divider().padding(.vertical,-1)
            
            // 좋아요 버튼
            HStack(spacing: 17) {
                Button {
                    print("좋아요")
                    Task {
                        await vocabularyNetworkManager.addLikes(voca: vocabulary)
                        await vocabularyNetworkManager.countLikes()

                    }
                    isLike.toggle()
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: isLike ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .font(.title2)
                            .foregroundColor(Color(hex: "737DFE"))
//                        Text("\(vocabulary.likes)")
//                            .foregroundColor(.mint)
                        ForEach(vocabularyNetworkManager.likes) { like in
                            if like.id == vocabulary.id {
                                Text("\(like.likeCount)")
                            }
                        }
//                        Text("\(vocabulary.likes)")
                    }
                }
                Button {
                    print("싫어요")
                    
                    Task {
                        await vocabularyNetworkManager.addDisLikes(voca: vocabulary)
                        await vocabularyNetworkManager.countLikes()

                    }
                    isDislike.toggle()
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: isDislike ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                            .font(.title2)
                            .foregroundColor(Color(hex: "737DFE"))
//                        Text("\(vocabulary.dislikes)")

                        ForEach(vocabularyNetworkManager.likes) { like in
                            if like.id == vocabulary.id {
                                Text("\(like.dislikeCount)")
                            }
                        }
//                        Text("\(vocabulary.dislikes)")

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
            .environmentObject(VocabularyNetworkManager())
    }
}
