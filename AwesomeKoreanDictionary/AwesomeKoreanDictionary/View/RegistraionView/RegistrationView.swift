//
//  RegistrationView.swift
//  AwesomeKoreanDictionary
//
//  Created by 정소희 on 2023/01/05.
//

import SwiftUI

struct RegistrationView: View {
    var loginTest: Bool = false
    
    var body: some View {
        VStack{
            if loginTest {
                //로그인이 안되어있다면 로그인뷰
                ContentView()
            } else {
                //로그인이 되어있다면 바로 속어 등록 뷰
                SlangRegistrationView()
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
