//
//  ListCell.swift
//  AwesomeKoreanDictionary
//
//  Created by TAEHYOUNG KIM on 2023/01/05.
//



import SwiftUI

struct ListCell: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.word)]) var voca: FetchedResults<BookmarkedVoca>
    @EnvironmentObject var vocabularyNetworkManager: VocabularyNetworkManager
    @State private var isLike: Bool = false
    @State private var isDislike: Bool = false
    @State private var isBookmark: Bool = false
    @State private var sharedSheet: Bool = false
    @State private var selection: String = "ko"
    @State private var translatedDefinition = ""
    @State private var translatedExample = ""
    
    var vocabulary: Vocabulary
    var languages = ["ENG", "CHN", "JPN"]
    var languageCodes = ["en", "zh-CN", "ja"]
    
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
                    Text("KOR").tag("ko")
                    ForEach(languages.indices) { index in
                        Text(languages[index]).tag(languageCodes[index])
                    }
                } label: {
                    Text("언어 선택")
                }
                .onChange(of: selection, perform: { value in
                    
                    if String(value) == "ko" {
                      
                    } else {
                        Task {
                            translatedDefinition = try await PapagoNetworkManager.shared.requestTranslate(sourceString: vocabulary.definition, target: String(value))
                            translatedExample = try await PapagoNetworkManager.shared.requestTranslate(sourceString: vocabulary.example, target: String(value))
                        }
                    }
                    
                    
                })
                .frame(height: 30)
                .tint(.black)
                
                Button {
                    isBookmark.toggle()
                    if !isBookmark {
                        managedObjContext.delete(voca[0])
                        
                        do {
                            try managedObjContext.save()
                        } catch {
                            print(error)
                        }
                    } else {
                        DataController().addVoca(word: vocabulary.word, definition: vocabulary.definition, pronunciation: vocabulary.pronunciation, context: managedObjContext)
                    }
                    
                } label: {
                    Image(systemName: isBookmark ? "bookmark.fill" : "bookmark")
                        .foregroundColor(Color(hex: "737DFE"))
                        .font(.title2)
                        .padding(.trailing, -5)
                }
            }
            
            // 내용
            VStack(alignment: .leading, spacing: 5) {
                Text("정의")
                    .foregroundColor(.gray)
                Text(selection == "ko" ? vocabulary.definition : translatedDefinition) // 이 내용을 번역본으로 변경
                    .lineSpacing(7)
            }
            .padding(.bottom, -10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("예시")
                    .foregroundColor(.gray)
                VStack(alignment: .leading, spacing: 10) {
                    Text(selection == "ko" ? "• \(vocabulary.example)" : "• \(translatedExample)") // 이 내용을 번역본으로 변경
                        .italic()
//                    ForEach(vocabulary.example, id: \.self) { example in
//
//                        Text("• \(example)")
//                            .italic()
//                    }
                }
            }
          //  .padding(.bottom, 10)
            
            

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

                        ForEach(vocabularyNetworkManager.likes) { like in
                            if like.id == vocabulary.id {
                                Text("\(like.likeCount)")
                            }
                        }
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
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let item = voca[index]
            managedObjContext.delete(item)
        }
        
        do {
            try managedObjContext.save()
        } catch {
            print(error)
        }
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell(vocabulary: dictionary[0])
            .environmentObject(VocabularyNetworkManager())
    }
}
