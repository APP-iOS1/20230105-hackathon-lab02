//
//  DescriptionTextView.swift
//  AwesomeKoreanDictionary
//
//  Created by 이주희 on 2023/02/03.
//

import SwiftUI

struct DescriptionTextView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("새로운 신조어를 공유해주세요!")
                }
                .font(.title3)
                .bold()
                Spacer()
            }
            .padding(5)
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("'Awesome Korean Dictionary'는 외국인을 위한 한국어 신조어&속어 사전입니다. 한글로 내용을 작성해 주시면, 번역 기능을 사용해 외국인이 쉽게 볼 수 있습니다.")
                    Text("해당 단어의 의미와 유래, 예문을 함께 작성해 주시면 외국인의 단어 이해에 큰 도움이 됩니다!")
                    Text("등록해 주신 단어는 관리자의 검수 및 승인 이후 노출되며,\n최종 등록까지 최대 3일이 소요될 수 있습니다.")
                        .font(.caption)
                        .foregroundColor(.blue)
                        .padding(.vertical,5)
                }
                .font(.subheadline)
                .padding(5)
                Spacer()
            }
        }
    }
}

struct DescriptionTextView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionTextView()
    }
}
