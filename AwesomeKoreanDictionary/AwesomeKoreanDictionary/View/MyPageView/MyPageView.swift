//
//  MyPageView1.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

import SwiftUI

struct MyPageView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var userInfoManager: UserInfoManager
    var body: some View {
        if authManager.state == .signedIn {
            SignedInMyPage().environmentObject(userInfoManager)
        } else {
            SignedOutMyPage()
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}

