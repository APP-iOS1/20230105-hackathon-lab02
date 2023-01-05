//
//  Card.swift
//  AwesomeKoreanDictionary
//
//  Created by 이소영 on 2023/01/05.
//

import Foundation
import SwiftUI

struct Card: Identifiable {
    
    var id = UUID().uuidString
    var cardColor: Color
    var offset: CGFloat = 0
    var koreanWord: String
    var meaning: String
    
}
