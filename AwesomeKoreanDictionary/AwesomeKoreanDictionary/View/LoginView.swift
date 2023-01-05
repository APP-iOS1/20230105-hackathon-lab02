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
    @EnvironmentObject var viewModel: AuthManager
    @State private var userID = ""
    @State private var userPassword = ""
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.square")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                        
                }.padding(.trailing, 10)
            }
            
            Spacer()
            
            Text("SIGN IN")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.blue)
            VStack {
                Text("Please sign in to register new words")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                
                GoogleSignInButton()
                    .frame(width: 320)
                    .onTapGesture {
                        viewModel.signIn()
                    }
                
            }.frame(height: 100)
                .padding()
                .background(.blue)
                .padding(.bottom, 50)
            
            Spacer()
        }
        .onAppear {
            Task {
                let string = try await PapagoNetworkManager.shared.requestTranslate(sourceString: "안녕하세요", target: .english)
                print(string)
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
        LoginView().environmentObject(AuthManager())
    }
}
