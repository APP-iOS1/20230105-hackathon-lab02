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
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "737DFE"), Color(hex: "FFCAC9")]),
                           startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {

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

                    GoogleSignInButton()
                        .frame(width: 320)
                        .onTapGesture {
                            authManager.signIn()
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
    }
}
