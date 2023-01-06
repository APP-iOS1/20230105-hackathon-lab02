//
//  MyPageView_EditUserInfoView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

import SwiftUI

struct MyPageView_EditUserInfoView: View {

    @Environment(\.dismiss) var dismiss

    @State private var userNickName: String = "YOOJ"
  
    @EnvironmentObject var userInfoManager: UserInfoManager


    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "737DFE"), Color(hex: "FFCAC9")]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack{
                

                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.white.opacity(0.7))
                }
                .padding(20)
                .padding(.bottom, 45)
                
//                ZStack{
//                    Rectangle()
//                        .frame(width: .infinity, height: 70)
//                        .foregroundColor(.black)
//                    Text("이것은 당신의 정의가 사전에 게시될 때 \n 게시글 아래에 나타날 이름이다.")
//                        .foregroundColor(.white)
//                        .font(.callout)
//                }
                
                VStack(alignment: .leading){
                    Text("닉네임")
                        .font(.title2)
                    
                    TextField("닉네임을 입력하세요.", text: $userNickName)
                        .scrollContentBackground(.hidden)
                        .padding()
                        .foregroundColor(.gray)
                        .background(Color.white)
                        .frame(width: 350, height: 65)
                        
                }
                .padding(.bottom, 20)
                
                Button(action: {
                                Task{
                    await userInfoManager.updateUserNickName(nickname: userNickName)
                    userInfoManager.fetchUserInfo()
                }
                
                }) {
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "737DFE"))
                            .frame(width: 350, height: 60)
                            .overlay {
                                Text("저장하기")
                                    .foregroundColor(.white)
                                    .fontWeight(.black)
                                    .font(.title3)
                            }
                    }
                }
                Spacer()

            }
        }
        .onAppear(){
            userInfoManager.fetchUserInfo()
            userNickName = userInfoManager.userInfo?.userNickname ?? ""
        }
    }
}

struct MyPageView_EditUserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView_EditUserInfoView()
    }
}
