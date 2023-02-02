//
//  QuizView.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/05.
//

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var vocabularyNetworkManager: VocabularyNetworkManager
    @ObservedObject var papagoNetworkManager = PapagoNetworkManager()
    @Namespace var name
    @State private var swipedIndex = 0
    @State private var selectedCard = Card(cardId: 0, name: "Sketch", offset: 0, definition: "1")
    @State var isShowing = false
    @State var quizResetButtonShowing = false
    @State var test: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("한국 신조어&속어 퀴즈 챌린지")
                            .fontWeight(.heavy)
                            .kerning(-1)
                            .font(.system(size: 45))
                            .foregroundColor(.white)
                        
                        HStack(spacing: 5) {
                            Text("당신의 한국어 능력을 테스트하세요!")
                                .kerning(-1)
                                .font(.system(size: 25))
                                .foregroundColor(Color.white.opacity(0.7))
                        }
                        .padding(.leading,5)
                    }
                    .padding(.vertical, 30)
                    
                    Spacer(minLength: 0)
                }
                .padding()
                
                GeometryReader { reader in
                    ZStack {
                        if quizResetButtonShowing {
                            HStack {
                                Button {
                                    Task {
                                        await vocabularyNetworkManager.vocabularyToCard()
                                    }
                                    swipedIndex = 0
                                    quizResetButtonShowing = false
                                } label: {
                                    Image(systemName: "arrow.counterclockwise")
                                    Text("퀴즈 새로 불러오기")
                                        .font(.title2)
                                        .bold()
                                        .kerning(-1)
                                }
                                .padding(.top, 30)
                                
                                Text(test)
                            }
                            .font(.title)
                            .foregroundColor(.white)
                            .offset(x: 0)
                        }
                        
                        
                        ForEach(vocabularyNetworkManager.cards.reversed()) { card in
                            CardView(swipedIndex: $swipedIndex, isShowing: $isShowing, selectedCard: $selectedCard, card: card, reader: reader, name: name)
                                .offset(x: card.offset)
                                .rotationEffect(.init(degrees: getRotation(offset: card.offset)))
                                .gesture(
                                    DragGesture()
                                        .onChanged({ value in
                                            withAnimation {
                                                if value.translation.width < 0 {
                                                    vocabularyNetworkManager.cards[card.cardId].offset = value.translation.width
                                                }
                                            }
                                        })
                                    
                                        .onEnded({ value in
                                            withAnimation {
                                                if value.translation.width < 150 {
                                                    vocabularyNetworkManager.cards[card.cardId].offset = -1000
                                                    swipedIndex = card.cardId + 1
                                                } else {
                                                    vocabularyNetworkManager.cards[card.cardId].offset = 0
                                                }
                                                
                                            }
                                            if card.cardId == 6 {
                                                quizResetButtonShowing = true
                                            } else {
                                                quizResetButtonShowing = false
                                            }
                                            
                                        })
                                )
                        }
                    }
                    .offset(y: -25)
                }
                .padding(.top, 10)
                Text(("카드를 왼쪽으로 스와이프하세요."))
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                    .kerning(-1)
                    .padding(.bottom, 30)
            }
            if isShowing {
                Detail(isShowing: $isShowing, card: selectedCard, name: name)
            }
        }
        .task{
            await vocabularyNetworkManager.vocabularyToCard()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(hex: "737DFE"), Color(hex: "FFCAC9")]),
                           startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            .opacity(isShowing ? 0 : 1)
        )
    }
    
    func restoreCard(id: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                vocabularyNetworkManager.cards[vocabularyNetworkManager.cards.count - 1].offset = 0
            }
        }
    }
    
    func getRotation(offset: CGFloat) -> Double {
        let value = offset / 150
        let angle: CGFloat = 5
        let degree = Double(value * angle)
        
        return degree
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
            .environmentObject(VocabularyNetworkManager())
    }
}
