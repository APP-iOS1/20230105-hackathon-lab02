//
//  SwiftUIView.swift
//  AwesomeKoreanDictionary
//
//  Created by 이주희 on 2023/01/05.
//

import SwiftUI
import GoogleSignIn

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var authManager: AuthManager
//    @Binding var isShowingSheet: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "737DFE"), Color(hex: "FFCAC9")]),
                           startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
//                HStack {
//                    Spacer()
//                    Button {
//                        dismiss()
//                    } label: {
//                        Image(systemName: "xmark")
//                            .resizable()
//                            .frame(width: 25, height: 25)
//                            .foregroundColor(Color.white.opacity(0.7))
//                    }.padding(.trailing, 30)
//                        .padding(.top, 30)
//                }

                Spacer()

                
                Text("SIGN IN")
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                VStack {
                    Text("Please sign in to register new words!")
                        .font(.title3)
                        .fontWeight(.medium)
                        .kerning(-0.5)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
//                    Button {
//                        authManager.signIn()
//                        dismiss()
//                    } label: {
//                        Text("로그인")
//                    }

                    GoogleSignInButton()
                        .frame(width: 320)
                        .onTapGesture {
                            authManager.signIn()
//                                if authManager.state == .signedIn {
//                                    isShowingSheet = false
//                                }
//                            print(isShowingSheet)
                        }
                }
                .frame(height: 100)
                .padding()
                
                .padding(.bottom, 50)
                
                Spacer()
            }
        }
    }
}

struct GoogleSignInButton: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
    
    private var button = GIDSignInButton()
    
    func makeUIView(context: Context) -> GIDSignInButton {
        button.colorScheme = colorScheme == .dark ? .dark : .light
        return button
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        button.colorScheme = colorScheme == .dark ? .dark : .light
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
//        LoginView(isShowingSheet: .constant(true)).environmentObject(AuthManager())
    }
}
