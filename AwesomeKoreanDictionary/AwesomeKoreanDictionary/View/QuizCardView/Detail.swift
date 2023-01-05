//
//  Detail.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/05.
//

import SwiftUI

struct Detail: View {
    
    @Binding var isShowing: Bool
    
    var card: Card
    var name: Namespace.ID

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12, content: {
                Button(action: {
                    withAnimation(.spring()) {
                        isShowing.toggle()
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.black)
                })

                Spacer(minLength: 0)

            })
            .padding(.leading, 20)
            .padding([.top, .bottom, .trailing])

            // For smaller size phones
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 12, content: {
                            Text(card.name)
                                .font(.system(size: 45, weight: .bold))
                                .foregroundColor(.black)
                            
                            // TODO: - 어떤 데이터를 보여줄지
                            Text("Design tools")
                                .font(.system(size: 30))
                                .foregroundColor(.black)
                            // TODO: - 어떤 데이터를 보여줄지
                            Text("Free")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .padding(.top, 10)
                        })

                        Spacer(minLength: 0)

                        
                    }
                    .padding(.vertical)

                    // TODO: - text alignment
                    Text("정의: \(card.definition).")
                        .font(.system(size: 22))
                        .foregroundColor(Color.black.opacity(0.7))
                        .multilineTextAlignment(.leading)
                        .padding(.top)
                }
                .padding(.horizontal, 20)
            })
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.white)
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
