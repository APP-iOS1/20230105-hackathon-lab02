//
//  MyPage_SignIn.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

import SwiftUI

struct SignedInMyPage: View {
    
    @EnvironmentObject var userInfoManager: UserInfoManager
    @EnvironmentObject var authManager: AuthManager
    @State private var userNickname: String = ""
    @State private var showEditViewModal: Bool = false
    @State var isPrivacySheetOn: Bool = false //개인정보 보호정책
    @State var isCreditSheetOn: Bool = false //크레딧
    @State private var showingAlert = false
    @State private var isAdmin = false
    var body: some View {
        
        NavigationStack{
            VStack {
                VStack(alignment: .leading) {
                    
                    HStack{
                        Text("\(userNickname) 입니다.")
                            .font(.title2)
                            .padding()
                        
                        Spacer()
                        
                        Button {
                            self.showEditViewModal.toggle()
                        } label: {
                            Text("수정하기")
                                .foregroundColor(.white)
                                .frame(width: 80, height: 30)
                                .padding(.horizontal,10)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .cornerRadius(10)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color(hex: "737DFE"))
                                )
                        }
                        .padding(.trailing, 25)
                        .buttonStyle(.plain)
                        .fullScreenCover(isPresented: $showEditViewModal){
                            EditUserInfoView(userNickname: $userNickname)
                        }
                    } // 상단 내 닉네임 노출 및 개인 정보 수정 HStack 끝
                    
                    // 리스트 시작
                    VStack {
                        
                        List {
                            Group {
                                Text("마이 페이지")
                                    .font(.title3)
                                    .padding(.top)
                                
                                NavigationLink{
                                    MyBookmarkView()
                                } label: {
                                    Text("내가 북마크한 단어들")
                                        .padding(.horizontal)
                                }
                                NavigationLink {
                                    MyRegisterView()
                                } label: {
                                    Text("내가 등록한 단어들")
                                        .padding(.horizontal)
                                }
                                NavigationLink {
                                    DeleteAccountView()
                                } label: {
                                    Text("계정 탈퇴하기")
                                        .padding(.horizontal)
                                }
                                Text("설정")
                                    .font(.title3)
                                    .padding(.top)
                                NavigationLink{
                                    SelectingLanguageView()
                                } label: {
                                    Text("언어")
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
                                
                                Text("관리자 로그인")
                                    .font(.title3)
                                    .padding(.top)
                            }
                                if userInfoManager.userInfo?.isAdmin == true {
                                    NavigationLink{
                                        AdminMainView()
                                            .onAppear{print("\(isAdmin)")}
                                    } label : {
                                        Text("관리자 로그인하기")
                                            .padding(.horizontal)
                                    }
                                }
                            
                        }
                        
                        
                        Button {
                            showingAlert = true
                            
                        } label: {
                            Text("로그아웃")
                        }.buttonStyle(.plain)
                            .alert(isPresented: $showingAlert){
                                Alert(title: Text("정말 로그아웃\n하시겠습니까?"), message: Text(""), primaryButton: .destructive(Text("로그아웃")){authManager.signOut()}, secondaryButton: .cancel())
                            }
                    }
                }
                .listStyle(.plain)
            }
        }
        .task{
            await userInfoManager.fetchUserInfo(userId: authManager.currentUserInfo.id)
            // FIXME: user
            userNickname = userInfoManager.userInfo?.userNickname ?? ""
            isAdmin = userInfoManager.userInfo?.isAdmin ?? false
        }
    } // NavigationStack 끝
}


struct SignedInMyPage_Preview: PreviewProvider {
    static var previews: some View {
        SignedInMyPage()
            .environmentObject(AuthManager())
            .environmentObject(UserInfoManager())
    }
}


