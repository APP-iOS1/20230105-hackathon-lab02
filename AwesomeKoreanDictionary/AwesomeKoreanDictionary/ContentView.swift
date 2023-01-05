//
//  ContentView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cardModel = CardModel()
    
    var body: some View {

            QuizCardView()
                .environmentObject(cardModel)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
