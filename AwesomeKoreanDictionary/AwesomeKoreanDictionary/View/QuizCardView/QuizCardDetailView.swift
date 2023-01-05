//
//  QuizCardDetailView.swift
//  AwesomeKoreanDictionary
//
//  Created by 이소영 on 2023/01/05.
//

import SwiftUI

struct QuizCardDetailView: View {
    @EnvironmentObject var quizCard: CardModel
    var card: Card
    var animation: Namespace.ID
    var body: some View {
        VStack {
            
            Text(card.koreanWord)
                .font(.system(size: 40))
                .bold()
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.top, 100)
                .padding(.bottom, 50)
                .matchedGeometryEffect(id: "Date-\(card.id)", in: animation)
            
            Text("What do you think it means? \nClick to see definition!")
                .font(.headline)
                .frame(width: 250, alignment: .leading)
                .foregroundColor(Color.black.opacity(0.8))
                .padding(.leading, 30)
                .padding(.vertical, 10)
                .matchedGeometryEffect(id: "question-\(card.id)", in: animation)
            
            Spacer(minLength: 0)
            
            HStack {
                Spacer(minLength: 0)
                
                Text("정답 보기")

                Image(systemName: "arrow.right")
            }
            .foregroundColor(Color.black.opacity(0.8))
            .padding(30)
            .padding(.bottom, 100)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            card.cardColor
            .cornerRadius(25)
            .shadow(radius: 3)
            .matchedGeometryEffect(id: "bgColor-\(card.id)", in: animation)
        )
        .onTapGesture {
            withAnimation(.spring()) {
                quizCard.selectedCard = card
                quizCard.showCard.toggle()
            }
        }


    }
}

struct QuizCardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
