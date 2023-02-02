//
//  MyPageView_EditUserInfoView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

import SwiftUI

struct EditUserInfoView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var userNickname: String
    @EnvironmentObject var userInfoManager: UserInfoManager
    @EnvironmentObject var authManager: AuthManager
    @State private var showingAlert = false
    
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
                
                VStack(alignment: .leading){
                    Text("닉네임")
                        .font(.title2)
                    
                    TextField("닉네임을 입력하세요.", text: $userNickname)
                        .scrollContentBackground(.hidden)
                        .padding()
                        .foregroundColor(.gray)
                        .background(Color.white)
                        .frame(width: 350, height: 65)
                        .cornerRadius(10)
                    
                }
                .padding(.bottom, 20)
                
                Button {
                    if userNickname == "" {
                       showingAlert = true
                    } else {
                        Task {
                            await userInfoManager.updateUserNickName(id: authManager.currentUserInfo.id, nickname: userNickname)
                            await userInfoManager.fetchUserInfo(userId: authManager.currentUserInfo.id)
                            dismiss()
                        }
                    }
                } label: {
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
                .alert("한 글자 이상 입력해주세요.", isPresented: $showingAlert) {
                    Button("Ok") { }
                }
                Spacer()
            }
        }
        .onAppear(){
            userNickname = userInfoManager.userInfo?.userNickname ?? ""
        }
    }
}

//프리뷰 하나 추가

//struct MyPageView_EditUserInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyPageView_EditUserInfoView()
//    }
//}
