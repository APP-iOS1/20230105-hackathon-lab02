//
//  MasterMainView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/06.
//

import SwiftUI

struct AdminMainView: View {
    @EnvironmentObject var authManager: AuthManager
    @State var isApprovedView: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "737DFE"), Color(hex: "FFCAC9")]),
                           startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading){
                Text("관리자 계정")
                    .font(.title2)
                    .fontWeight(.semibold)
                Divider()
                HStack{
                    Button(action: {
                        isApprovedView = true
                    }, label: {
                        Text("승인 대기중")
                            .foregroundColor(isApprovedView ? Color.AKDBlack : Color.gray)
                    })
                    Button(action: {
                        isApprovedView = false
                    }, label: {
                        Text("승인 완료")
                            .foregroundColor(isApprovedView ? Color.AKDGray : Color.AKDBlack)
                    })
                }
                Spacer()
                
                if isApprovedView {
                    WaitingApproveView()
                } else {
                    ApprovedView()
                }
            }
            .padding()
        }
    }
}

struct MasterMainView_Previews: PreviewProvider {
    static var previews: some View {
        AdminMainView().environmentObject(AuthManager())
    }
}
