//
//  Card.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/05.
//

import SwiftUI

struct Card: Identifiable {
    var cardId: Int
    var name: String
    var offset: CGFloat
    var definition: String
    
    var id: Int {
        return cardId
    }
}
