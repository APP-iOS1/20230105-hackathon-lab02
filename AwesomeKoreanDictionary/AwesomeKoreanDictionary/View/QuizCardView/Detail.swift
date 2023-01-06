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

    var languageCodes: [String] = ["en", "zh-CN", "ja"]
    var languages: [String] = ["English", "Chinese", "Japanese"]
    @State private var selectedLanguage: String = ""

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
                            })
                            
                            Spacer(minLength: 0)
                            
                            Picker("Select Language", selection: $selectedLanguage) {
                                Text("한국어")
                                ForEach(0..<languages.count) { idx in
                                    Text(languages[idx]).tag(languageCodes[idx])
                                }
                            }
                            .onChange(of: selectedLanguage, perform: { value in
                                Task {
                                    self.translate = try await PapagoNetworkManager.shared.requestTranslate(sourceString: card.definition, target: String(value))
                                }
                            })
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 50)
                        
                        // TODO: - text alignment
                        
                        VStack(alignment: .leading) {
                            Text("정의: \(card.definition)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "424242"))
                                .padding(.vertical, 5)
                            
                            Text("번역: \(translate)")
                                .font(.title2)
                                .foregroundColor(Color(hex: "424242"))
                                .multilineTextAlignment(.leading)
                                .lineSpacing(10)
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 20)
                })
            }
        }
            .navigationBarBackButtonHidden(true)
            .background(Color.white)
//        .onAppear { //  (Void) return
////            "en","zh-CN","ja"
//            if (selectedLanguage == "en") {
//                Task {
//                    self.translate = try await PapagoNetworkManager.shared.requestTranslate(sourceString: card.definition, target: PapagoNetworkManager.TargetLanguage.english)
//
//                    print("EN: \(translate)")
//                }
//            } else if (selectedLanguage == "zh-CN") {
//                Task {
//                    self.translate = try await PapagoNetworkManager.shared.requestTranslate(sourceString: card.definition, target: PapagoNetworkManager.TargetLanguage.chinese)
//
//                    print("CN: \(translate)")
//                }
//            } else if (selectedLanguage == "ja") {
//                Task {
//                    self.translate = try await PapagoNetworkManager.shared.requestTranslate(sourceString: card.definition, target: PapagoNetworkManager.TargetLanguage.japanese)
//
//                    print("JP: \(translate)")
//                }
//            }
//        }
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
