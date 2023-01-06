//
//  TestVIew.swift
//  AwesomeKoreanDictionary
//
//  Created by TAEHYOUNG KIM on 2023/01/05.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var vocabularyNetworkManager: VocabularyNetworkManager
    var body: some View {
        
        ForEach(dic) { voca in
            Button {
                Task {
                    await vocabularyNetworkManager.createVoca(voca: voca)
                }
            } label: {
                Text("\(voca.word) 서버에 올리기")
            }
        }
        Text("테스트")
        
        //        ForEach(vocabularyNetworkManager.vocabularies) { voca in
        //            Text(voca.word)
        //            ForEach(vocabularyNetworkManager.likes) { like in
        //                if voca.id == like.id {
        //                    Text("\(like.count)")
        //                }
        //            }
        //
        //
        //            }
        //        .onAppear {
        //            Task {
        //                await vocabularyNetworkManager.countLikes()
        //            }
        //        }
        //        }
        
    }
}

var dic: [Vocabulary] = [

    Vocabulary(id: UUID().uuidString, word: "그 잡채", pronunciation: "[ Geu Japchae ]", definition: "‘~ 그 자체’를 다른 방식으로 표현한 말", example: "와 니네 현실 남매 그 잡채다.", likes: 10, dislikes: 0, creatorId: "덕이", isApproved: true),
    Vocabulary(id: UUID().uuidString, word: "캘박", pronunciation: "[ kaelbak ]", definition: "‘캘린더 박제’의 줄임말", example: "그래 이 날 만나자~ 캘박할게~", likes: 3, dislikes: 2, creatorId: "종이", isApproved: true),
    Vocabulary(id: UUID().uuidString, word: "모에모에뀽", pronunciation: "[ moemoekkiung ]", definition: "음식 앞에서 외치는 음식이 맛있어지는 주문", example: "야 잠깐만. 모에모에뀽! 됐어 먹어도 돼.", likes: 3, dislikes: 2, creatorId: "덕이", isApproved: true),
    Vocabulary(id: UUID().uuidString, word: "통모짜핫도그", pronunciation: "[ Tongmojjahotdog ]", definition: "통 못자서 피곤한 상태를 뜻하는 신조어", example: "아 개피곤하다. 나 오늘 레알 통모짜핫도그임.", likes: 10, dislikes: 1, creatorId: "종이", isApproved: true),
    Vocabulary(id: UUID().uuidString, word: "kijul", pronunciation: "[ Kijeol ]", definition: "‘기절’을 영어로 표기한 것", example: "오늘 해커톤 끝나고 바로 kijul할듯", likes: 3, dislikes: 2, creatorId: "종이", isApproved: true),
    Vocabulary(id: UUID().uuidString, word: "빤쓰런", pronunciation: "[ Bbansseurun ]", definition: "해병대를 비난하기 위해 만들어진 표현이지만 최근엔 그런 의미는 없어지고 허둥지둥 도망간다는 의미가 되었다.", example: "귀신을 보자마자 그는 빤쓰런을 했다", likes: 16, dislikes: 2, creatorId: "덕이", isApproved: true),
    Vocabulary(id: UUID().uuidString, word: "웅니", pronunciation: "[ Woongni ]", definition: "‘언니’를 귀엽게 발음한 말", example: "웅니 저희 언제봐여~", likes: 21, dislikes: 1, creatorId: "덕이", isApproved: true),
    Vocabulary(id: UUID().uuidString, word: "SBN", pronunciation: "[Sbn]", definition: "‘선배님’의 영어 이니셜", example: "SBN 어디세요?", likes: 5, dislikes: 2, creatorId: "종이", isApproved: true),
    Vocabulary(id: UUID().uuidString, word: "드르륵 탁", pronunciation: "[ Deureureuk Tak ]", definition: "테이프 되감기 소리. 다시 보고싶은 장면이나 다시 듣고싶은 말이 있을 때 사용하는 말", example: "(재밌는 장면 지나감) ??? : 드르륵 탁!", likes: 17, dislikes: 0, creatorId: "덕이", isApproved: true),
    Vocabulary(id: UUID().uuidString, word: "웃안웃", pronunciation: "[ Wootanwoot ]", definition: "웃긴데 안 웃김.", example: "(누가 장난 침) ㅎㅎ 웃안웃;", likes: 41, dislikes: 1, creatorId: "덕이", isApproved: true),
    Vocabulary(id: UUID().uuidString, word: "너 뭐 돼?", pronunciation: "[ Neo Muo Dwae? ]", definition: "뭐가 잘나서 그런 말 혹은 행동을 하냐는 뜻", example: "니가 그렇게 잘났어? 너 뭐 돼?", likes: 40, dislikes: 10, creatorId: "덕이", isApproved: true),
    Vocabulary(id: UUID().uuidString, word: "재질", pronunciation: "[ Jaejil ]", definition: "느낌이 난다는 것을 표현할 때  쓰는 말", example: "쟤 진짜 잘생겼다. 인터넷 소설 남자주인공 재질이야", likes: 20, dislikes: 5, creatorId: "덕이", isApproved: true),
    Vocabulary(id: UUID().uuidString, word: "킹받네", pronunciation: "[ King-batne ]", definition: "'킹받다'는 '열 받다'를 강조하기 위해 킹(king·왕)을 접두어처럼 사용한 신조어다. 한 마디로 엄청 화났다는 뜻이다.", example: "아, 미친 집에 핸드폰 두고 나왔어. 개킹받네.", likes: 0, dislikes: 0, creatorId: "덕이", isApproved: true),
    Vocabulary(id: UUID().uuidString, word: "중꺾마", pronunciation: "[ Joongkkeokma ]", definition: "‘중요한 건 꺾이지 않는 마음’의 줄임말", example: "패배해도 괜찮아, 중요한 건 꺾이지 않는 마음이야.", likes: 0, dislikes: 0, creatorId: "종이", isApproved: true)

]



struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
            .environmentObject(VocabularyNetworkManager())
    }
}
