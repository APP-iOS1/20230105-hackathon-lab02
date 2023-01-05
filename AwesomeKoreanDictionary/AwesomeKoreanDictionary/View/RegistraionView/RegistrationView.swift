//
//  RegistrationView.swift
//  AwesomeKoreanDictionary
//
//  Created by 정소희 on 2023/01/05.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        VStack{
            if authManager.state == .signedOut {
                //로그인이 안되어있다면 로그인뷰
                LoginView()
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
