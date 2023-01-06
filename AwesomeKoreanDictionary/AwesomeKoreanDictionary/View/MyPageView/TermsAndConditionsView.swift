//
//  TermsAndConditionsView.swift
//  AwesomeKoreanDictionary
//
//  Created by 정소희 on 2023/01/06.
//

import SwiftUI

struct TermsAndConditionsView: View {
    @Environment(\.dismiss) private var dismiss
     @Binding var sheet2: Bool
     
     var body: some View {
         VStack{
             Form{
                 Section{
                     Text("서비스 약관")
                         .font(.title2)
                         .fontWeight(.bold)
                     Text(TermsOfServiceText)
                 }
                 Section{
                     Text("이용 약관")
                         .font(.title2)
                         .fontWeight(.bold)
                     Text(termsAndConditionsText)
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
                             Text("모든 정보를 읽었고 동의합니다.")
                                 .foregroundColor(.white)
                                 .fontWeight(.black)
                                 .font(.title3)
                         }
                 }.padding(.top)
             }
         }
     }
     
     let TermsOfServiceText: String = """
 Awesome Korean Dictionary("회사")는 아래 선언된 서비스 약관에 따라 Awesome Korean Dictionary("앱")을 제공합니다. 회사는 이 약관을 수시로 수정할 수 있는 권리를 보유합니다. 우리는 웹사이트에 중요한 수정 사항에 대한 통지를 게시할 것입니다. 귀하가 해당 앱을 계속 사용하면 이 약관에 동의하는 것으로 간주됩니다. 서비스 약관에 대한 질문은 아래 주소로 보낼 수 있습니다.
 legal@awesomekoreandictionary.com
 """
     let termsAndConditionsText: String = """
 이 앱은 모든 사용자에게 적합하지 않습니다. 그 내용은 종종 불쾌감을 줄 수 있는 거칠고 직접적인 방식으로 제시됩니다. 자신이 적절한 사용자라고 생각하지 않거나 기분이 상했다면 이 앱을 사용하지 마십시오.

  이 앱은 13세 미만의 어린이를 대상으로 하지 않습니다. 이 앱을 사용함으로써 귀하는 귀하가 18세 이상이거나 귀하가 13세 이상이고 웹사이트를 사용할 수 있도록 부모의 허락을 받았음을 나타냅니다.

 귀하는 이 앱을 불법 활동이나 관할 지역의 법률을 위반하기 위해 사용할 수 없습니다.

 이 앱을 악용하여 승인되지 않은 정보에 액세스할 수 없습니다.

 회사는 통지 여부에 관계없이 어떤 이유로든 이 앱을 수정, 중단 또는 중단할 권리를 보유합니다.

  이 앱은 "있는 그대로" 그리고 "이용 가능한 상태로" 제공됩니다. 귀하는 앱 사용에 대한 전적인 책임과 위험을 감수합니다. 회사는 (i) 앱이 귀하의 요구 사항을 충족할 것, (ii) 귀하가 앱에 만족할 것, (iii) 귀하가 항상 앱을 사용할 수 있을 것, (iv) 앱이 오류, (v) 또는 모든 오류가 수정됩니다.

 회사는 귀하의 앱 사용으로 인한 손해 또는 손실에 대해 책임을 지지 않습니다.

 회사는 앱이 이메일과 같은 암호화되지 않은 네트워크를 통해 개인 메시지 등의 정보를 전송함으로써 발생하는 어떠한 손해나 손실에 대해서도 책임을 지지 않습니다.

 회사가 본 약관에 제공된 권리를 시행하거나 행사하지 못하는 것이 해당 권리의 포기가 아닙니다.

 본 서비스 약관의 어떤 조항이 유효하지 않거나 시행할 수 없는 것으로 판명되더라도 나머지 조항은 여전히 적용됩니다.

 본 서비스 약관은 귀하와 회사 간의 전체 계약을 구성하며 이전 버전의 서비스 약관을 포함하여 귀하와 회사 간의 모든 서면 또는 구두 계약을 대체합니다.
 """
 }
struct TermsAndConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditionsView(sheet2: .constant(true))
    }
}
