//
//  ContentView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthManager())
            .environmentObject(VocabularyNetworkManager())
    }
}
