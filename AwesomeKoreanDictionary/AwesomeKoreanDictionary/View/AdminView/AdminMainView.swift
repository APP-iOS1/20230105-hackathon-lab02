//
//  MasterMainView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/06.
//

import SwiftUI

//enum RegistedWordView: String{
//    case waitingApprove = "승인 대기중"
//    case approved = "승인 완료"
//}

struct AdminMainView: View {
    
    @EnvironmentObject var authManager: AuthManager
    //@State var registedWordView: RegistedWordView = .waitingApprove
    
    //var registedWordArray: [RegistedWordView] = [.waitingApprove, .approved]
    
    @State var isApprovedView: Bool = false
    
    var body: some View {
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
                        .foregroundColor(isApprovedView ? Color.black : Color.gray)
                })
                Button(action: {
                    isApprovedView = false
                }, label: {
                    Text("승인 완료")
                        .foregroundColor(isApprovedView ? Color.gray : Color.black)
                })
            }
            Spacer()
            
            if isApprovedView {
                WaitingApproveView()
            } else {
                ApprovedView()
            }
                
//                        Button {
//                            registedWordView = select
//                        } label: {
//                            Text(select.rawValue)
//                                .foregroundColor(registedWordView == select ? Color(.black) : Color(.gray))
//                                .font(.body)
//                        }
//                switch registedWordView{
//                case .waitingApprove:
//                    WaitingApproveView()
//                case .approved:
//                    ApprovedView()
//                }
            
        }
        .padding()
    }
}

struct MasterMainView_Previews: PreviewProvider {
    static var previews: some View {
        AdminMainView().environmentObject(AuthManager())
    }
}
