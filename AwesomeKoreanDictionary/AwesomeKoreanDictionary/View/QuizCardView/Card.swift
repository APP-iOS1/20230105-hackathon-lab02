//
//  Card.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/05.
//

import SwiftUI

/**
 QuizView에서 Vocabulary를 보여줄 카드 구조체
 */
struct Card: Identifiable {
    var cardId: Int
    var name: String
    var offset: CGFloat
    var definition: String
    
    var id: Int {
        return cardId
    }
}
