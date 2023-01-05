//
//  MyPageView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

import SwiftUI



struct MyPageView_SignOut: View {
    
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        
        let firstMyPageList: [String] = ["Language"]
        let secondMyPageList: [String] = ["Privacy Policy (개인정보 보호정책)", "Terms and Conditions (이용약관)"]
        let thirdMyPageList: [String] = ["Master Login"]
        NavigationStack{
            
            
           
            
            VStack {
                
                VStack(alignment: .leading) {
        
                        Text("Please sign in to vote \nand post new definitions")
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
                                Text("Sign with Gmail")
                                    .foregroundColor(.white)
                            }
                        }
                    
                    
                    // 리스트 시작
                    VStack {
                        List {
                            Text("Settings")
                                .font(.title3)
                                .padding(.top)
                            NavigationLink{
                                MyPageView_SelectingLanguageView()
                            } label: {
                            Text(firstMyPageList[0])
                                .padding(.horizontal)
                                
                            } // 첫번째 리스트
                            
                            Text("Help")
                                .font(.title3)
                                .padding(.top)
                            ForEach(secondMyPageList, id: \.self) {
                                listString in
                                HStack {
                                    Text(listString)
                                    Spacer()
                                    Image(systemName: "arrow.up.right")
                                    
                                }
                                .padding(.horizontal)
                            } // 두번째 리스트
                            
                            Text("Master")
                                .font(.title3)
                                .padding(.top)
                            
                            NavigationLink{
//                                MyPageView_MasterLoginView()
                            } label : {
                            Text(thirdMyPageList[0])
                                .padding(.horizontal)
                            }
                        }
                        .foregroundColor(.black)
                        .listStyle(.plain)
                    } // 리스트 끝
                }// 전체 한칸 안쪽 VStack 끝
            } // 전체 VStack 끝
        } // NavigationStack 끝
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView_SignOut()
    }
}
