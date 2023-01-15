//
//  Vocabulary.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/05.
//

import Foundation
import CoreData

struct Vocabulary: Identifiable, Hashable {
    var id: String
    var word: String
    var pronunciation: String
    var definition: String
    var example: String
    var likes: Int
    var dislikes: Int
    var creatorId: String
    var isApproved: Bool = false
}
