//
//  MyPageView_EditUserInfoView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

import SwiftUI
import FirebaseAuth

struct MyPageView_EditUserInfoView: View {

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vocabularyNetworkManager: VocabularyNetworkManager
    @EnvironmentObject var authManager: AuthManager
    @State private var userNickName: String = "YOOJ"
//    @ObservedObject var userNickName2 : AuthManager = AuthManager()
    // 닉네임 받아오는 프로퍼티 생성되면 변경할게요!

    var body: some View {
        VStack{
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title2)
            }
            .padding(20)
            .padding(.bottom, 45)

            ZStack{
            Rectangle()
                .frame(width: .infinity, height: 70)
                .foregroundColor(.black)
            Text("이것은 당신의 정의가 사전에 게시될 때 \n 게시글 아래에 나타날 이름이다.")
                .foregroundColor(.white)
                .font(.callout)
            }
        
            VStack(alignment: .leading){
                Text("닉네임")
                    .font(.title2)
                
                TextEditor(text: $userNickName)
                    .scrollContentBackground(.hidden)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .frame(width: 300, height: 65)
                    .cornerRadius(5)
            }
            
            Button {
//                vocabularyNetworkManager.updateUserNickName(userId: Auth.auth().currentUser.uid, nickname: userNickName)
            } label: {
                Text("저장")
                    .frame(width: 300, height: 50)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .background(.black)
            }
            Spacer()

        }
    }
}

struct MyPageView_EditUserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView_EditUserInfoView()
    }
}
