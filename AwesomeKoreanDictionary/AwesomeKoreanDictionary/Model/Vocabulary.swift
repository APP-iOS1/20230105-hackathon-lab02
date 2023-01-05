//
//  Vocabulary.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/05.
//

import Foundation

struct Vocabulary: Identifiable, Hashable {
    var id: String
    var word: String
    var pronunciation: String
    var definition: String
    var example: [String]
    var likes: Int
    var dislikes: Int
    var creatorId: String
    var isApproved: Bool = false
}


var dictionary: [Vocabulary] = [
    Vocabulary(
        id: "1",
        word: "킹받네",
        pronunciation: "[ King-batne ]",
        definition: "'킹받네' is a new word that uses king as a prefix to emphasize 'get angry'. In one word, it means very angry.",
        example: [
            "Oh i failed the test. really 킹받네.",
            "Look at him pretending to be cute. It's really 킹받네.",
            "Oh i left my phone at home. fuckin 킹받네."
        ],
        likes: 150,
        dislikes: 10,
        creatorId: "덕이"
    ),
    Vocabulary(
        id: "2",
        word: "킹받네",
        pronunciation: "[ King-batne ]",
        definition: "'킹받네' is a new word that uses king as a prefix to emphasize 'get angry'. In one word, it means very angry.",
        example: [
            "아, 시험 떨어졌어. 진짜 킹받네.",
            "쟤 귀여운척 하는거 봐봐. 킹받네.",
            "아, 미친 핸드폰 두고 나왔어. 개킹받네."
        ],
        likes: 150,
        dislikes: 10,
        creatorId: "덕이"
    ),
    
]
