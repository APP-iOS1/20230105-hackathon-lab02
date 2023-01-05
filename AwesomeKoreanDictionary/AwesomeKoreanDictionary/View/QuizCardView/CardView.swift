//
//  CardView.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/05.
//

import SwiftUI

struct CardView: View {
    
    @Binding var swipedIndex: Int
    @Binding var isShowing: Bool
    @Binding var selectedCard: Card
    
    var card: Card
    var reader: GeometryProxy
    var name: Namespace.ID

    var body: some View {
        LazyVStack {
            Spacer(minLength: 0)

            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                
                VStack {

                    HStack {
                        VStack(alignment: .leading, spacing: 12, content: {
                            Text(card.name)
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .foregroundColor(.black)

                            // TODO: - 넣을 데이터 생각해보기
                            Text("Design tool")
                                .font(.system(size: 20))
                                .foregroundColor(.black)

                            Button(action: {
                                withAnimation(.spring()) {
                                    selectedCard = card
                                    isShowing.toggle()
                                }
                            }, label: {
                                Text("정답 보기 >")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.orange)
                            })
                            .padding(.top)
                        })

                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 15)
                    .padding(.top, 25)
                }

            })
            .frame(height: reader.size.height/2)
            .padding(.vertical, 10)
            .background(Color.white)
            .cornerRadius(25)
            .padding(.horizontal, 30 + (CGFloat(card.cardId - swipedIndex) * 10))
            // 필요한 코드 건들지 X
            .offset(y:card.cardId - swipedIndex <= 2 ? CGFloat(card.cardId - swipedIndex) * 25 : 50)
            .shadow(color: Color.black.opacity(0.12), radius: 5, x: 0, y: 5)

            Spacer(minLength: 0)
        }
        .contentShape(Rectangle())
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
