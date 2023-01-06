//
//  Detail.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/05.
//

import SwiftUI

struct Detail: View {
    
    @Binding var isShowing: Bool
    
    @EnvironmentObject var papagoNetworkManager: PapagoNetworkManager
    
    var card: Card
    var name: Namespace.ID
    
    var languages: [String] = ["ENG", "CHN", "JPN"]
    @State private var selectedLanguage: Int = 0
    
    @State private var translate: String = ""
    @State private var isPickerDisappeared: Bool = false
    
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
                                
                                // TODO: - 어떤 데이터를 보여줄지
                                //                                Text("Design tools")
                                //                                    .font(.system(size: 30))
                                //                                    .foregroundColor(.black)
                                // TODO: - 어떤 데이터를 보여줄지

                            })
                            
                            Spacer(minLength: 0)
                            
                            
                            Picker("Select Language", selection: $selectedLanguage) {
                                ForEach((0 ..< languages.count)) { idx in
                                    Text(languages[idx])
                                }
                            }
                            .onAppear(perform: {
                                isPickerDisappeared = false
                            })
                            .onDisappear {
                                isPickerDisappeared = true
                            }
                            
                        }
                        .padding(.vertical)
                        
                        // TODO: - text alignment
                        if (isPickerDisappeared != true) {
                            Text("정의")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "424242"))
                                .padding(.vertical, 5)
                            Text("\(card.definition)")
                                .font(.title2)
                                .foregroundColor(Color(hex: "424242"))
                                .multilineTextAlignment(.leading)
                       
                        } else {
                            Text("정의")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "424242"))
                                .padding(.vertical, 5)
                            
                            Text("\(translate)")
                                .font(.title2)
                                .foregroundColor(Color(hex: "424242"))
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(.horizontal, 20)
                })
            }
            
            .onAppear { //  (Void) return
                if (selectedLanguage == 0) {
                    Task {
                        self.translate = try await PapagoNetworkManager.shared.requestTranslate(sourceString: card.definition, target: PapagoNetworkManager.TargetLanguage.english)
                        
                        print("EN: \(translate)")
                    }
                } else if (selectedLanguage == 1) {
                    Task {
                        self.translate = try await PapagoNetworkManager.shared.requestTranslate(sourceString: card.definition, target: PapagoNetworkManager.TargetLanguage.chinese)
                        
                        print("CN: \(translate)")
                    }
                } else if (selectedLanguage == 2) {
                    Task {
                        self.translate = try await PapagoNetworkManager.shared.requestTranslate(sourceString: card.definition, target: PapagoNetworkManager.TargetLanguage.japanese)
                        
                        print("JP: \(translate)")
                    }
                }
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
