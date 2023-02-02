//
//  TermsAndConditionsView.swift
//  AwesomeKoreanDictionary
//
//  Created by 정소희 on 2023/01/06.
//

import SwiftUI

struct CreditsView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isSheetOn: Bool
     
     var body: some View {
         VStack{
             Form{
                 Section{
                     Text("크레딧")
                         .font(.title2)
                         .fontWeight(.bold)
                     Text(TermsOfServiceText)
                 }
                 
             }
             Button(action: {
                 dismiss()
             }) {
                 ZStack{
                     RoundedRectangle(cornerRadius: 10)
                         .fill(Color.clear)
                         .frame(width: 350, height: 70)
                     RoundedRectangle(cornerRadius: 10)
                         .fill(Color(hex: "737DFE"))
                         .frame(width: 350, height: 60)
                         .overlay {
                             Text("확인")
                                 .foregroundColor(.white)
                                 .fontWeight(.black)
                                 .font(.title3)
                         }
                 }.padding(.top)
             }
         }
     }
     
     let TermsOfServiceText: String = """
 황유진 - 아이디어 제공자, 프론트엔드 개발
 추현호 - PM, 백엔드 개발
 박제균 - 백엔드 개발
 이주희 - 백엔드 개발
 홍진표 - 백엔드 개발
 최현종 - 프론트엔드 개발
 정소희 - 프론트엔드 개발
 김태형 - 프론트엔드 개발
 이소영 - 디자인, 프론트엔드 개발
 """

 }
struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView(isSheetOn: .constant(true))
    }
}
