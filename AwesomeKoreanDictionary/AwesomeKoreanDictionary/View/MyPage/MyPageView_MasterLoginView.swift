//
//  MyPageView_MasterLoginView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

import SwiftUI

struct MyPageView_MasterLoginView: View {
    
    @State private var masterEmail: String = ""
    @State private var masterPassword: String = ""
    // masterAccount 모델, 스토어 주세요 :)!
    
    var body: some View {
        VStack {
            Text("Master Login")
                .font(.title2)
                .bold()
            Divider()
            VStack (alignment: .leading){
                TextField("Master Account Email", text: $masterEmail)
                    .font(.subheadline)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 7).fill(.gray).frame(width: 300, height: 50))
                    .frame(width: 300, height: 50)
                    .padding(.bottom, 5.0)
                    .textInputAutocapitalization(.never)
                    // 모든 텍스트 소문자 입력
                
                SecureField("Master Account PassWord", text: $masterPassword)
                    .font(.subheadline)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 7).fill(.gray).frame(width: 300, height: 50))
                    .frame(width: 300, height: 50)
                
                Button {
                    // 마스터 계정 로그인하기 액션!
                } label: {
                    Text("Sign In")
                        .frame(width: 300, height: 50)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .background(.black)
                }
                .padding(.top,133)
            } // 제목, 로그인, 로그인 버튼 VStack 종료
        } // 전체 VStack 종료
        .padding()
            
    }
}

struct MyPageView_MasterLoginView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView_MasterLoginView()
    }
}
