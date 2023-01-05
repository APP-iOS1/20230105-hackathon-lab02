//
//  AnswerCardView.swift
//  AwesomeKoreanDictionary
//
//  Created by 이소영 on 2023/01/05.
//

import SwiftUI

struct AnswerCardView: View {
    @EnvironmentObject var quizCard: CardModel
    var animation: Namespace.ID
    //var card: Card
    var body: some View {
        
        VStack {
            VStack {
                Text(quizCard.selectedCard.koreanWord)
                    .font(.system(size: 40))
                    .bold()
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                    .padding(.top, 100)
                    .padding(.bottom, 50)
                    .matchedGeometryEffect(id: "Date-\(quizCard.selectedCard.id)", in: animation)
                
                Text(quizCard.selectedCard.meaning)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.black.opacity(0.8))
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .lineSpacing(10)
                    .matchedGeometryEffect(id: "Meaning-\(quizCard.selectedCard.id)", in: animation)
                
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                quizCard.selectedCard.cardColor
                    .cornerRadius(25)
                    .matchedGeometryEffect(id: "bgColor-\(quizCard.selectedCard.id)", in: animation)
                    .ignoresSafeArea(.all, edges: .bottom)
            )
            .onTapGesture {
                withAnimation(.spring()) {
                    quizCard.showCard.toggle()
                }
            }
            
        }
    }
}

struct AnswerCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
