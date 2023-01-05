//
//  MyPage_SignIn.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

import SwiftUI

struct MyPageView_SignIn: View {
    
    @EnvironmentObject var authManager: AuthManager
    @State private var userNickName: String = "YOOJ"
    @State private var showEditViewModal: Bool = false
    @State var sheet1: Bool = false //개인정보 보호정책
    @State var sheet2: Bool = false //이용약관
    var body: some View {
        
        let firstMyPageList: [String] = ["My BookMark (내가 북마크한 단어들)", "My Definitions (내가 등록한 단어들)"]
        let secondMyPageList: [String] = ["Language"]
        let thirdMyPageList: [String] = ["Privacy Policy (개인정보 보호정책)", "Terms and Conditions (이용약관)"]
        
        
        NavigationStack{
            VStack {
                VStack(alignment: .leading) {
                    
                    HStack{
                        Text("This is \(userNickName).")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                        
                        Spacer()
                        
                        Button {
                            self.showEditViewModal.toggle()
                        } label: {
                            Text("Edit")
                                .padding(4)
                                .padding(.horizontal,10)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color(.black), lineWidth: 1)
                                )
                        }.buttonStyle(.plain)
                            .fullScreenCover(isPresented: $showEditViewModal){
                                MyPageView_EditUserInfoView()
                            }
                    } // 상단 내 닉네임 노출 및 개인 정보 수정 HStack 끝
                    
                    // 리스트 시작
                    VStack {
                        
                        List {
                            Text("My Page")
                                .font(.title3)
                                .padding(.top)
                            
                            NavigationLink{
                                // 내가 북마크한 단어들 리스트뷰 필요
                            } label: {
                                Text("\(firstMyPageList[0])")
                                    .padding(.horizontal)
                            }
                            NavigationLink {
                                MyPageView_MyRegisterView()
                            } label: {
                                Text("\(firstMyPageList[1])")
                                    .padding(.horizontal)
                            }
                            Text("Settings")
                                .font(.title3)
                                .padding(.top)
                            NavigationLink{
                                MyPageView_SelectingLanguageView()
                            } label: {
                                ForEach(secondMyPageList, id: \.self) {
                                    listString in
                                    HStack {
                                        Text(listString)
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal)
                                
                            } // 첫번째 리스트 끄
                            
                            Text("Help")
                                .font(.title3)
                                .padding(.top)
                            
                            ForEach(0..<thirdMyPageList.count, id: \.self) {
                                index in
                                Button(action: {
                                    if thirdMyPageList[0] ==  thirdMyPageList[index] {
                                        sheet1.toggle()
                                    }
                                    if thirdMyPageList[1] ==  thirdMyPageList[index] {
                                        sheet2.toggle()
                                    }
                                }) {
                                    HStack {
                                        Text(thirdMyPageList[index])
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
                            } // 두번째 리스트 끝
                            
                            Button {
                                authManager.signOut()
                            } label: {
                                Text("로그아웃")
                                    .font(.title3)
                                    .padding(.top)
                            }.buttonStyle(.plain)
                        }
                    }
                    .listStyle(.plain)
                    // 리스트 끝
                }// 전체 한칸 안쪽 VStack 끝
            } // 전체 VStack 끝
        } // NavigationStack 끝
    }
}

struct MyPage_SignIn_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView_SignIn()
    }
}
