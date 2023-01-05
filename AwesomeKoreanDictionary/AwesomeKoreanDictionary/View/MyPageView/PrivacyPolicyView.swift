//
//  PrivacyPolicyView.swift
//  AwesomeKoreanDictionary
//
//  Created by 정소희 on 2023/01/06.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) private var dismiss
     @Binding var sheet1: Bool
     
     var body: some View {
         VStack{
             Form{
                 Section{
                     Text("개인정보의 수집 및 이용목적")
                         .font(.title2)
                         .fontWeight(.bold)
                     Text(purposeOfUseText)
                 }
                 Section{
                     Text("처리하는 개인정보 항목 및 보유기간")
                         .font(.title2)
                         .fontWeight(.bold)
                     Text(retentionPeriodText)
                 }
                 Section{
                     Text("개인정보 수집에 대한 동의")
                         .font(.title2)
                         .fontWeight(.bold)
                     Text(acceptCollectionText)
                 }
                 Section{
                     Text("개인정보의 제3자 제공")
                         .font(.title2)
                         .fontWeight(.bold)
                     Text(thirdPartyProvisionText)
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
                         .fill(Color.mint)
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
     
     let purposeOfUseText: String = """
 재단은 개인정보를 다음의 목적이외의 용도로는 이용하지 않으며 이용 목적이 변경될 경우
 에는 동의를 받아 처리하겠습니다. 1. 서비스 제공
 홈페이지, 교육콘텐츠 제공, 시찰, 관람, 공모전, 자문단, 강사파견, 동아리, 각종 회의 및 대
 회의 개최와 운영을 목적으로 개인정보를 처리합니다. 2. 민원, 행정처리
 행정처리, 개인정보 열람, 개인정보 정정·삭제, 개인정보 처리정지 요구, 개인정보 유출사고
 신고, 개인정보 침해사실 신고접수·처리, 스팸민원고충처리, 해킹신고 등 민원처리를 목적으
 로 개인정보를 처리합니다.
 """
     let securityMeasuresText: String = """
 재단은 법령의 규정과 정보주체의 동의에 의해서만 개인정보를 수집·보유합니다
 """
    let retentionPeriodText: String = """
재단 홈페이지는 고객이 개인정보처리방침 또는 이용약관의 내용에 대한 동의 절차(‘동의한
다’ 버튼)를 마련하여, 해당 버튼을 체크하면 개인정보 수집에 대해 동의한 것으로 간주합니
다. 또한, 고객은 개인정보 수집에 대해 동의하지 않을 권리가 있으며, 동의하지 않을 경우
에는 일부 컨텐츠 이용제한, 민원신청 또는 상담이 거부될 수 있습니다.
"""
    let acceptCollectionText: String = """
재단 홈페이지는 고객이 개인정보처리방침 또는 이용약관의 내용에 대한 동의 절차(‘동의한
다’ 버튼)를 마련하여, 해당 버튼을 체크하면 개인정보 수집에 대해 동의한 것으로 간주합니
다. 또한, 고객은 개인정보 수집에 대해 동의하지 않을 권리가 있으며, 동의하지 않을 경우
에는 일부 컨텐츠 이용제한, 민원신청 또는 상담이 거부될 수 있습니다.
"""
    let thirdPartyProvisionText: String = """
재단이 수집·보유하고 있는 개인정보는 이용자의 동의없이는 제3자에게 제공하지 않으며 다
음의 경우에는 개인정보를 제3자에게 제공할 수 있습니다. 1. 정보주체로부터 별도의 동의를 받은 경우
2. 법률에 특별한 규정이 있거나 법령상 의무를 준수하기 위하여 불가피한 경우
3. 정보주체 또는 그 법정대리인이 의사표시를 할 수 없는 상태에 있거나 주소불명 등으로
사전동의를 받을 수 없는 경우로서 명백히 정보주체 또는 제3자의 급박한 생명, 신체, 재산
의 이익을 위하여 필요하다고 인정되는 경우
4. 다음 각 호의 어느 하나에 해당하는 경우에는 정보주체 또는 제3자의 이익을 부당하게
침해할 우려가 있을 때를 제외하고는 이용자의 개인정보 를 목적 외의 용도로 이용하거나
이를 제3자에게 제공할 수 있습니다. 가. 정보주체로부터 별도의 동의를 받은 경우
나. 다른 법률에 특별한 규정이 있는 경우
다. 정보주체 또는 그 법정대리인이 의사표시를 할 수 없는 상태에 있거나 주소불명 등으로
사전동의를 받을 수 없는 경우로서 명백히 정보주체 또는 제3자의 급박한 생명, 신체, 재산
의 이익을 위하여 필요하다고 인정되는 경우
라. 통계작성 및 학술연구 등의 목적을 위하여 필요한 경우로서 특정 개인을 알아볼 수 없
는 형태로 개인정보를 제공하는 경우
마. 개인정보를 목적 외의 용도로 이용하거나 이를 제3자에게 제공하지 아니하면 다른 법률
에서 정하는 소관 업무를 수행할 수 없는 경우로서 보호위원회의 심의·의결을 거친 경우
바. 조약, 그 밖의 국제협정의 이행을 위하여 외국정부 또는 국제기구에 제공하기 위하여
필요한 경우
사. 범죄의 수사와 공소의 제기 및 유지를 위하여 필요한 경우
아. 법원의 재판업무 수행을 위하여 필요한 경우
자. 형(刑) 및 감호, 보호처분의 집행을 위하여 필요한 경우
"""
    
    
    
    
 }
struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView(sheet1: .constant(true))
    }
}
