//
//  MyPageView_MyBookmarkView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/06.
//

import SwiftUI
import CoreData

struct MyPageView_MyBookmarkView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.word)]) var voca: FetchedResults<BookmarkedVoca>
    
    let languages = ["KOR", "ENG", "CHN", "JPN"]
    @State private  var selection: String = "KOR"
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "737DFE"), Color(hex: "FFCAC9")]),
                           startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack {
                
                Text("북마크한 단어들")
                List {
                    ForEach(voca) { voca in
                        VStack(alignment: .leading, spacing: 20) {
                            
                            // 단어의 이름
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    Text(voca.word!)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .padding(.bottom, -3)
                                        .foregroundColor(Color(hex: "292929"))
                                    Text("voca.pronunciation!")
                                        .font(.title3)
                                        .padding(.bottom, -5)
                                }
                                Spacer()
                                
                                Picker(selection: $selection) {
                                    ForEach(languages, id: \.self) { lang in
                                        Text(lang)
                                    }
                                } label: {
                                    Text("")
                                }
                                .frame(height: 30)
                                .tint(.black)
                                
                                //                            Button {
                                //                                print("북마크 버튼")
                                //                                isBookmark.toggle()
                                //                                //coreData에 저장
                                //            //                    DataController().addVoca(word: vocabulary.word, definition: vocabulary.definition, context: managedObjContext)
                                //
                                //                            } label: {
                                //                                Image(systemName: isBookmark ? "bookmark.fill" : "bookmark")
                                //                                    .foregroundColor(Color(hex: "737DFE"))
                                //                                    .font(.title2)
                                //                                    .padding(.trailing, -5)
                                //                            }
                            }
                            
                            // 내용
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Definition")
                                    .foregroundColor(.secondary)
                                Text("voca.definition!")
                                    .lineSpacing(7)
                            }
                            .padding(.bottom, -10)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Example")
                                    .foregroundColor(.secondary)
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("• voca example")
                                        .italic()
                                }
                            }
                            
                            // 사용자 이름 / 날짜
                            HStack {
                                Text("by voca creatorId")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hex: "292929"))
                                Spacer()
                            }
                            
                            Divider().padding(.vertical,-1)
                            
                            HStack(spacing: 17) {
                                Button {
                                    print("공유")
                                } label: {
                                    ShareLink(item: voca.word!) {
                                        Image(systemName: "square.and.arrow.up")
                                            .font(.title2)
                                    }
                                }
                            }
                            .padding(.top, -5)
                        }
                        .foregroundColor(.black)
                        .padding(10)
                        .frame(width: 360)
                        .background(Color.white)
                        .cornerRadius(20)
                    }
                    .onDelete(perform: deleteVoca)
                }
                .listStyle(.plain)
                
            }
            
        }
        
    }
    //     Deletes voca at the current offset
    private func deleteVoca(offsets: IndexSet) {
        withAnimation {
            offsets.map { voca[$0] }
                .forEach(managedObjContext.delete)
            
            // Saves to our database
            DataController().save(context: managedObjContext)
        }
    }
}

struct MyPageView_MyBookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView_MyBookmarkView()
    }
}
