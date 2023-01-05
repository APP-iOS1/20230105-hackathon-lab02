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
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "737DFE"), Color(hex: "FFCAC9")]),
                           startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack {
                HStack(alignment: .top, spacing: 12, content: {
                    Button(action: {
                        withAnimation(.spring()) {
                            isShowing.toggle()
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.white.opacity(0.7))
                    })
                    Spacer(minLength: 0)
                })
                .padding(.leading, 20)
                .padding([.top, .bottom, .trailing])
                
                // For smaller size phones
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading, spacing: 12, content: {
                                Text(card.name)
                                    .font(.system(size: 45, weight: .heavy))
                                    .foregroundColor(.white)
                                
//                                // TODO: - 어떤 데이터를 보여줄지
//                                Text("Design tools")
//                                    .font(.system(size: 30))
//                                    .foregroundColor(Color(hex: "292929"))
                                // TODO: - 어떤 데이터를 보여줄지

                            })
                            Spacer(minLength: 0)
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 50)
                        
                        // TODO: - text alignment
                        VStack(alignment: .leading) {
                            Text("Definition")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "424242"))
                                .padding(.vertical, 5)
                            
                            Text("\(card.definition)")
                                .font(.title2)
                                .foregroundColor(Color(hex: "424242"))
                                .multilineTextAlignment(.leading)
                                .lineSpacing(10)
                        }
                    }
                    .padding(.horizontal, 30)
                })
            }
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
