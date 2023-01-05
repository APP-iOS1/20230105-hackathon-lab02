//
//  MyPageView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

import SwiftUI



struct MyPageView_SignOut: View {
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var userInfoManager: UserInfoManager
    @State var sheet1: Bool = false //개인정보 보호정책
    @State var sheet2: Bool = false //이용약관
    var body: some View {
        
        let firstMyPageList: [String] = ["언어"]
        let secondMyPageList: [String] = ["개인정보 보호정책", "이용 약관"]
        let thirdMyPageList: [String] = ["관리자 로그인"]
        NavigationStack{
            VStack {
                VStack(alignment: .leading) {
        
                        Text("새로운 단어를 정의하려면 로그인하세요")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                            
                    
                        Button {
                            authManager.signIn()
                        } label: {
                            ZStack{
                                Rectangle()
                                    .padding(.leading)
                                    .frame(width: 170, height: 50)
                                    .foregroundColor(.black)
                                Text("구글 로그인하기")
                                    .foregroundColor(.white)
                            }

                        }
                    }
                    
                    // 리스트 시작
                    VStack {
                        List {
                            Text("설정")
                                .font(.title3)
                                .padding(.top)
                            NavigationLink{
                                MyPageView_SelectingLanguageView()
                            } label: {
                                Text(firstMyPageList[0])
                                    .padding(.horizontal)
                                
                            } // 첫번째 리스트
                            Text("도움")
                                .font(.title3)
                                .padding(.top)
                            
                            ForEach(0..<secondMyPageList.count, id: \.self) {
                                index in
                                Button(action: {
                                    if secondMyPageList[0] ==  secondMyPageList[index] {
                                        sheet1.toggle()
                                    }
                                    if secondMyPageList[1] ==  secondMyPageList[index] {
                                        sheet2.toggle()
                                    }
                                }) {
                                    HStack {
                                        Text(secondMyPageList[index])
                                        Spacer()
                                        Image(systemName: "arrow.up.right")
                                    }
                                }
                                //개인정보 보호정책 시트뷰
                                .sheet(isPresented: $sheet1, content: {
                                    PrivacyPolicyView(sheet1: $sheet1)
                                })
                                // 이용약관 시트뷰
                                .sheet(isPresented: $sheet2, content: {
                                    TermsAndConditionsView(sheet2: $sheet2)
                                })
                                .padding(.horizontal)
                            } // 두번째 리스트
                            
                            Text("관리자 로그인")
                                .font(.title3)
                                .padding(.top)

                            if userInfoManager.userInfo?.isAdmin == true {
                                NavigationLink{
                                    AdminMainView()
                                } label : {
                                    Text(thirdMyPageList[0])
                                        .padding(.horizontal)
                                }

                            }
                        }
                        .foregroundColor(.black)
                        .listStyle(.plain)
                    } // 리스트 끝
                }// 전체 한칸 안쪽 VStack 끝
            }
            .onAppear(){
                userInfoManager.fetchUserInfo()
            }
            // 전체 VStack 끝
        } // NavigationStack 끝
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView_SignOut()
    }
}
