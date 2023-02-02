//
//  MainLoadingView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/06.
//

import SwiftUI

import SwiftUI

struct MainLoadingView: View {
    
    @State private var isActive = false
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color("logoColor")
                    .ignoresSafeArea()
                Image("appLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    self.isActive = true
                }
            }
        }
    }
}

struct MainLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        MainLoadingView()
    }
}

