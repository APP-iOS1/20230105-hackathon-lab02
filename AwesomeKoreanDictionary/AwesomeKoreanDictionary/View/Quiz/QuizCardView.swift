//
//  QuizCardView.swift
//  AwesomeKoreanDictionary
//
//  Created by 이소영 on 2023/01/05.
//

import SwiftUI

var width = UIScreen.main.bounds.width

struct QuizCardView: View {
    @EnvironmentObject var quizCard: CardModel
    @Namespace var animation
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    ForEach(quizCard.cards.indices.reversed(), id:\.self) { index in
                        
                        HStack {
                            QuizCardDetailView(card: quizCard.cards[index], animation: animation)
                                .frame(width: getCardWidth(index: index), height: getCardHeight(index: index))
                                .offset(x: getCardOffset(index: index))
                                .rotationEffect(.init(degrees: getCardRotation(index: index)))
                            
                            Spacer(minLength: 0)
                        }
                        .frame(height: 700)
                        .contentShape(Rectangle())
                        .offset(x: quizCard.cards[index].offset)
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged({ (value) in
                                onChanged(value: value, index: index)
                            }).onEnded({ (value) in
                                onEnd(value: value, index: index)
                            }))
                    }
                }
                .padding(.top, 40)
                .padding(.horizontal, 30)
                
                Button(action: resetViews, label: {
                    Image(systemName: "arrow.left")
                        .font(.body)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                })
                .padding(.top, -30)
                
                Spacer()
            }
            
            if quizCard.showCard {
                AnswerCardView(animation: animation)
            }
            
        }
    }
    
    func resetViews() {
        for index in quizCard.cards.indices {
            withAnimation(.spring()) {
                quizCard.cards[index].offset = 0
                quizCard.swipedCard = 0
            }
        }
    }
    
    func onChanged(value: DragGesture.Value, index: Int) {
        // only left swift..
        if value.translation.width < 0 {
            quizCard.cards[index].offset = value.translation.width
        }
    }
    
    func onEnd(value: DragGesture.Value, index: Int) {
        withAnimation {
            if -value.translation.width > width / 3 {
                quizCard.cards[index].offset = -width
                quizCard.swipedCard += 1
            } else {
                quizCard.cards[index].offset = 0
            }
        }
    }
    
    func getCardRotation(index: Int) -> Double {
        let boxWidth = Double(width / 3)
        let offset = Double(quizCard.cards[index].offset)
        let angle: Double = 5
        return (offset / boxWidth) * angle
    }
    
    func getCardHeight(index: Int) -> CGFloat {
        let height : CGFloat = 500
        let cardHeight = index - quizCard.swipedCard <= 2 ? CGFloat(index - quizCard.swipedCard) * 35 : 70
        return height - cardHeight
    }
    
    func getCardWidth(index: Int) -> CGFloat {
        let boxWidth = UIScreen.main.bounds.width - 60 - 60
        return boxWidth
    }
    
    func getCardOffset(index: Int) -> CGFloat {
        return index - quizCard.swipedCard <= 2 ? CGFloat(index - quizCard.swipedCard) * 30 : 60
    }
}

struct QuizCardView_Previews: PreviewProvider {
    static var previews: some View {
        QuizCardView()
    }
}
