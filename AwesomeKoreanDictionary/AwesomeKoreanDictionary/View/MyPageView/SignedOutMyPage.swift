//
//  MyPageView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

import SwiftUI
import AuthenticationServices
import _AuthenticationServices_SwiftUI

struct SignedOutMyPage: View {
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var userInfoManager: UserInfoManager
    @State var isPrivacySheetOn: Bool = false //개인정보 보호정책
    @State var isCreditSheetOn: Bool = false //크레딧
    var body: some View {

        NavigationStack{
            VStack {
                VStack {
                    
                    Text("새로운 단어를 정의하려면 로그인하세요")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding()
                    
                    SignInWithAppleButton { (request) in
                        authManager.nonce = randomNonceString()
                        request.requestedScopes = [.email, .fullName]
                        request.nonce = sha256(authManager.nonce)
                    } onCompletion: { (result) in
                        switch result{
                        case .success(let user):
                            print("success")
                            guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                                print("error with firebase")
                                return
                            }
                            authManager.authenticate(credential: credential)
                            authManager.state = .signedIn
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    .signInWithAppleButtonStyle(.black)
                    .frame(width: 200, height: 40)
                    .cornerRadius(10)
                    
                    Button {
                        authManager.signIn()
                    } label: {
                        ZStack{
                            Rectangle()
                                .frame(width: 200, height: 40)
                                .foregroundColor(Color(hex: "737DFE"))
                                .cornerRadius(10)
                            Text("구글 로그인하기")
                                .foregroundColor(.white)
                        }
                    }
                }
                
                VStack {
                    List {
                        Text("마이 페이지")
                            .font(.title3)
                            .padding(.top)
                        
                        NavigationLink{
                            MyBookmarkView()
                        } label: {
                            Text("내가 북마크한 단어들")
                                .padding(.horizontal)
                        }
                        
                        Text("설정")
                            .font(.title3)
                            .padding(.top)
                        NavigationLink{
                            SelectingLanguageView()
                        } label: {
                            Text("언어")
                                .padding(.horizontal)
                            
                        }
                        Text("도움")
                            .font(.title3)
                            .padding(.top)
                        
                        NavigationLink{
                            PrivacyPolicyView(isSheetOn: $isPrivacySheetOn)
                        } label: {
                            Text("개인정보 보호정책")
                                .padding(.horizontal)
                        }
                        
                        NavigationLink{
                            CreditsView(isSheetOn: $isCreditSheetOn)
                        } label: {
                            Text("크레딧")
                                .padding(.horizontal)
                        }

                        .foregroundColor(.black)
                    } // 리스트 끝
                    .listStyle(.plain)
                }// 전체 한칸 안쪽 VStack 끝
            }
            // 전체 VStack 끝
        } // NavigationStack 끝
    }
}


struct SignedOutMyPage_Preview: PreviewProvider {
    static var previews: some View {
        SignedOutMyPage()
    }
}
