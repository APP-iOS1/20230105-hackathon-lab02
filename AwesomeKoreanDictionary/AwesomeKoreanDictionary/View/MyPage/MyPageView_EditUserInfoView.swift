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
            Text("This is the name your definitions will appear\nunder when they're published on Urban Dictionary.")
                .foregroundColor(.white)
                .font(.callout)
            }
        
            VStack(alignment: .leading){
                Text("NickName")
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
                // 변경된 닉네임 저장하기
            } label: {
                Text("Save")
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
