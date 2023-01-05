//
//  CardModel.swift
//  AwesomeKoreanDictionary
//
//  Created by 이소영 on 2023/01/05.
//

import SwiftUI

class CardModel: ObservableObject {
    
    @Published var cards = [
        Card(cardColor: Color.yellow, koreanWord: "중꺾마", meaning: "‘중요한 건 꺾이지 않는 마음’의 줄임말"),
        Card(cardColor: Color.teal, koreanWord: "통모짜핫도그", meaning: "통 못자서 피곤한 상태를 뜻하는 신조어"),
        Card(cardColor: Color.purple, koreanWord: "폼 미쳤다", meaning: "'폼(form)+미쳤다'로, 대단하다, 기량이 좋다, 상태가 좋다는 의미. 실력이 좋다, 웃기다, 멋지다, 힙하다 등 넓은 의미로 사용되고 있다. 보통 칭찬의 의미지만 비꼬거나 놀릴 때도 반어법처럼 사용될 수 있어 맥락을 잘 파악해야 한다."),
        Card(cardColor: Color.green, koreanWord: "농협은행", meaning: "‘농협은행 어디예요?’를 ‘너무 예쁘네요’로 잘못 알아들은 썰에서 나온 신조어. ‘너무 예쁘다’라는 뜻으로 쓰임"),
        Card(cardColor: Color.orange, koreanWord: "내봬누", meaning: "환승연애2 출연자 현규가 해은에게 했던 설레는 멘트에서 유래된 신조어. ‘내일 봬요 누나’의 줄임말"),
        Card(cardColor: Color.pink, koreanWord: "어쩔티비", meaning: "‘어쩌라고 가서 티비나 봐’라는 뜻에서 유래했다는 설이 있고, 주로 어린 아이들이 많이 쓰면서 유명해짐"),
        Card(cardColor: Color.cyan, koreanWord: "오히려좋아", meaning: "예상하지 못한 안 좋은 일이 발생했을 때 오히려 큰 그림을 그리며 이를 긍정적으로 본다는 말. 스트리머이자 유튜버인 침착맨이 사용하면서 유명해짐")
    ]
    
    @Published var swipedCard = 0
    
    @Published var showCard = false
    @Published var selectedCard = Card(cardColor: .clear, koreanWord: "", meaning: "")
}
