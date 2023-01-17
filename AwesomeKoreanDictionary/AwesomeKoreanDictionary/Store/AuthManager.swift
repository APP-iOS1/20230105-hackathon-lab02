//
//  AuthManager.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/05.
//

import Firebase
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
import CryptoKit
import AuthenticationServices
import SwiftUI

final class AuthManager: ObservableObject {
    @Published var nonce = ""
    
    enum signInState {
        case signedIn
        case signedOut
    }
    var googleUser: GIDGoogleUser?
    @Published var state: signInState = .signedOut
    @Published var currentUser = GIDSignIn.sharedInstance.currentUser
    @Published var user: User = User(id: "", isAdmin: false, userNickname: "", userEmail: "")
    @Published var currentUserInfo: User = User(id: "", isAdmin: false, userNickname: "", userEmail: "")
    
    func signIn() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                
                let db = Firestore.firestore()
                let currentUserID = user?.userID ?? ""
                let userRef = db.collection("user").document(currentUserID)
                
                userRef.getDocument {
                    (document, error) in
                    if document!.exists {
                        let docData = document!.data()
                        let id: String = docData?["id"] as? String ?? ""
                        let isAdmin: Bool = docData?["isAdmin"] as? Bool ?? false
                        let userEmail: String = docData?["userEmail"] as? String ?? ""
                        let userNickname: String = docData?["userNickname"] as? String ?? ""
                        
                        self.currentUserInfo.id = id
                        self.currentUserInfo.isAdmin = isAdmin
                        self.currentUserInfo.userEmail = userEmail
                        self.currentUserInfo.userNickname = userNickname
                    } else {
                        userRef.setData([
                            "id": currentUserID,
                            "isAdmin": false,
                            "userEmail": user?.profile?.email ?? "",
                            "userNickname": user?.profile?.name ?? ""
                        ], merge: true)
                        
                        self.currentUserInfo.id = currentUserID
                        self.currentUserInfo.isAdmin = false
                        self.currentUserInfo.userEmail = user?.profile?.email ?? ""
                        self.currentUserInfo.userNickname = user?.profile?.name ?? ""
                    }
                }
                
                authenticateUser(for: user, with: error)
            }
        } else {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
                if let googleUser = result?.user {
                    
                    let db = Firestore.firestore()
                    let currentUserID = googleUser.userID ?? ""
                    let userRef = db.collection("user").document(currentUserID)
                    print(currentUserID)
                    
                    userRef.getDocument {
                        (document, error) in
                        if document!.exists {
                            let docData = document!.data()
                            let id: String = docData?["id"] as? String ?? ""
                            let isAdmin: Bool = docData?["isAdmin"] as? Bool ?? false
                            let userEmail: String = docData?["userEmail"] as? String ?? ""
                            let userNickname: String = docData?["userNickname"] as? String ?? ""
                            
                            self.currentUserInfo.id = id
                            self.currentUserInfo.isAdmin = isAdmin
                            self.currentUserInfo.userEmail = userEmail
                            self.currentUserInfo.userNickname = userNickname
                        } else {
                            userRef.setData([
                                "id": currentUserID,
                                "isAdmin": false,
                                "userEmail": googleUser.profile?.email ?? "",
                                "userNickname": googleUser.profile?.name ?? ""
                            ], merge: true)
                            
                            self.currentUserInfo.id = currentUserID
                            self.currentUserInfo.isAdmin = false
                            self.currentUserInfo.userEmail = googleUser.profile?.email ?? ""
                            self.currentUserInfo.userNickname = googleUser.profile?.name ?? ""
                        }
                    }
                    
                    self.currentUserInfo.id = currentUserID
                    self.currentUserInfo.isAdmin = false
                    self.currentUserInfo.userEmail = googleUser.profile?.email ?? ""
                    self.currentUserInfo.userNickname = googleUser.profile?.name ?? ""
                }
                self.authenticateUser(for: result?.user, with: error)
            }
        }
    }
    
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        if let error = error {
#if DEBUG
            print("\(error.localizedDescription)")
#endif
            return
        }
        guard let authenticationToken = user?.accessToken.tokenString, let idToken = user?.idToken?.tokenString else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authenticationToken)
        
        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if let error = error {
#if DEBUG
                print("\(error.localizedDescription)")
#endif
            } else {
                self.state = .signedIn
            }
        }
    }
    
    // MARK: SIGN OUT
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        do {
            try Auth.auth().signOut()
            state = .signedOut
            UserInfoManager().userInfo = nil
        } catch {
#if DEBUG
            print("\(error.localizedDescription)")
#endif
        }
    }
    
    //MARK: - Apple log-in
    
    
    
    
    func authenticate(credential: ASAuthorizationAppleIDCredential){
        
        guard let token = credential.identityToken else{
            print("error with firebase")
            
            return
        }
        
        guard let tokenString = String(data: token, encoding: .utf8) else{
            print("error with Token")
            return
        }
        
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
        
        Auth.auth().signIn(with: firebaseCredential) { (result, err) in
            let db = Firestore.firestore()
            let currentUserID = result?.user.uid ?? ""
            let userRef = db.collection("user").document(currentUserID)
            
            userRef.getDocument {
                (document, error) in
                if document!.exists {
                    let docData = document!.data()
                    let id: String = docData?["id"] as? String ?? ""
                    let isAdmin: Bool = docData?["isAdmin"] as? Bool ?? false
                    let userEmail: String = docData?["userEmail"] as? String ?? ""
                    let userNickname: String = docData?["userNickname"] as? String ?? ""
                    
                    self.currentUserInfo.id = id
                    self.currentUserInfo.isAdmin = isAdmin
                    self.currentUserInfo.userEmail = userEmail
                    self.currentUserInfo.userNickname = userNickname
                } else {
                    userRef.setData([
                        "id": currentUserID,
                        "isAdmin": false,
                        "userEmail": result?.user.email ?? "",
                        "userNickname": result?.user.email ?? ""
                    ], merge: true)
                    
                    self.currentUserInfo.id = currentUserID
                    self.currentUserInfo.isAdmin = false
                    self.currentUserInfo.userEmail = result?.user.email ?? ""
                    self.currentUserInfo.userNickname = result?.user.email ?? ""
                }
            }
            
            if let error = err{
#if DEBUG
                print("\(error.localizedDescription)")
#endif
                return
            }
        }
#if DEBUG
        print("Logged In")
#endif
        withAnimation(.easeInOut){
            self.state = .signedIn
        }
    }
}

func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
    }.joined()
    
    return hashString
}

func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                preconditionFailure(
                    "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                )
            }
            return random
        }
        
        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }
            
            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }
    return result
}
