//
//  QuizView.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/05.
//

import SwiftUI

struct QuizView: View {

    @ObservedObject var vocabularyNetworkManager = VocabularyNetworkManager()
    // TODO: - Quiz로 보여줄 단어는 어떻게 정할건지? - likes수가 높은 상위 몇개의 단어?
//    @State var cards = [
//        Card(cardId: 0, name: "중꺾마", offset: 0, definition: "‘중요한 건 꺾이지 않는 마음’의 줄임말"),
//        Card(cardId: 1, name: "Figma", offset: 0, definition: "2"),
//        Card(cardId: 2, name: "XD", offset: 0, definition: "3"),
////        Card(id: 3, name: "Ilustrator", offset: 0, definition: "4"),
////        Card(id: 4, name: "Photoshop", offset: 0, definition: "5"),
////        Card(id: 5, name: "Invision", offset: 0, definition: "6"),
////        Card(id: 6, name: "Affinity Photos", offset: 0, definition: "7"),
////        Card(id: 7, name: "Affinity Photos", offset: 0, definition: "8"),
////        Card(id: 8, name: "Affinity Photos", offset: 0, definition: "9"),
////        Card(id: 9, name: "Affinity Photos", offset: 0, definition: "10")
//    ]

    // To track which card is swiped
    @State private var swipedIndex = 0
    @Namespace var name
    @State private var selectedCard = Card(cardId: 0, name: "Sketch", offset: 0, definition: "1")
    @State var isShowing = false

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 12) {
                        // TODO: - QuizView 제목달기
                        Text("Products")
                            .font(.system(size: 45))
                            .foregroundColor(.white)

                        HStack(spacing: 15) {
                            Text("Design tools")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .foregroundColor(Color.white.opacity(0.7))
                        }
                    }

                    Spacer(minLength: 0)
                }
                    .padding()

                // Stacked Elements
                GeometryReader { reader in
                    ZStack {
                        // ZStack will overlay on one another so revesing
                        ForEach(vocabularyNetworkManager.cards.reversed()) { card in
                            CardView(card: card, reader: reader, swipedIndex: $swipedIndex, isShowing: $isShowing, selectedCard: $selectedCard, name: name)
                                .offset(x: card.offset)
                                .rotationEffect(.init(degrees: getRotation(offset: card.offset)))
                                .gesture(
                                DragGesture()
                                    .onChanged({ value in
                                    // Update position
                                    withAnimation {
                                        // Only left swipe
                                        if value.translation.width < 0 {
                                            vocabularyNetworkManager.cards[card.cardId].offset = value.translation.width
                                        }
                                    }
                                })
                                    .onEnded({ value in
                                    withAnimation {
                                        if value.translation.width < 150 {
                                            vocabularyNetworkManager.cards[card.cardId].offset = -1000
                                            // Update swipe id
                                            // Since its starting from 0
                                            swipedIndex = card.cardId + 1

                                            restoreCard(id: card.cardId)
                                        } else {
                                            vocabularyNetworkManager.cards[card.cardId].offset = 0
                                        }
                                    }
                                })
                            )
                        }
                    }
                        .offset(y: -25)
                }
                    .padding(.top, 50)
            }

            if isShowing {
                Detail(card: selectedCard, isShowing: $isShowing, name: name)
            }
        }
        .onAppear {
            Task {
                do {
                    try await vocabularyNetworkManager.vocabularyToCard()
                    print(vocabularyNetworkManager.cards)
                } catch {
                    print(error)
                }
            }
        }
            .background(
            Color.mint
                .edgesIgnoringSafeArea(.all)
            // Disable bg color when its expanded
            .opacity(isShowing ? 0 : 1)
        )
    }

    // Add card to list
    func restoreCard(id: Int) {
//        var currentCard = cards[id]
        var currentCard = vocabularyNetworkManager.cards[id]
        // append last
        currentCard.cardId = vocabularyNetworkManager.cards.count

        vocabularyNetworkManager.cards.append(currentCard)

        // Go back effect
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                // last one we append
                vocabularyNetworkManager.cards[vocabularyNetworkManager.cards.count - 1].offset = 0
            }
        }
    }

    // Rotation
    func getRotation(offset: CGFloat) -> Double {
        let value = offset / 150

        // You can give your own angle here
        let angle: CGFloat = 5

        let degree = Double(value * angle)

        return degree
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
