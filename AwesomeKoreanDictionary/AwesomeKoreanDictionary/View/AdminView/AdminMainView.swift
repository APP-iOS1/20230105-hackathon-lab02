//
//  MasterMainView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/06.
//

import SwiftUI

struct AdminMainView: View {
    
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        VStack{
            Text("관리자 페이지")
            
        }
      
    }
}

struct MasterMainView_Previews: PreviewProvider {
    static var previews: some View {
        AdminMainView()
    }
}
