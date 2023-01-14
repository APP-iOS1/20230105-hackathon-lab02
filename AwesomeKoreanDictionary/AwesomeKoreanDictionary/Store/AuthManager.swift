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


class AuthManager: ObservableObject {
    @Published var nonce = ""
    
    enum signInState {
        case signedIn
        case signedOut
    }
    var googleUser: GIDGoogleUser?
    @Published var state: signInState = .signedOut
    @Published var currentUser = GIDSignIn.sharedInstance.currentUser
    //  -----
    @Published var user: User = User(id: "", isAdmin: false, userNickname: "", userEmail: "")
    // 로그인시 여기에 currentUser 정보를 저장한다
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
                        print("로그인 완료 1")
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
                        print("가입 완료 1")
                    }
                }

                authenticateUser(for: user, with: error)
            }
        } else {
//            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
                if let googleUser = result?.user {
                    
                    let db = Firestore.firestore()
                    let currentUserID = googleUser.userID ?? ""
                    let userRef = db.collection("user").document(currentUserID)
                    print(currentUserID)
                    
                    // 저장되지 않은 유저 정보
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
                            print("로그인 완료 2")
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
                            print("가입 완료 2")
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
        // Handle the error and return it early from the method.
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        // Get the idToken and accessToken from the user instance.
        guard let authenticationToken = user?.accessToken.tokenString, let idToken = user?.idToken?.tokenString else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authenticationToken)
        
        // Use them to sign in to Firebase. If there are no errors, change the state to signedIn.
        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if let error = error {
                print(error.localizedDescription)
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
            print(error.localizedDescription)
        }
    }
    
    //  -----
    /*
     func checkSignUp() -> Void {
     
     let db = Firestore.firestore()
     
     let user = Auth.auth().currentUser
     
     db.collection("user").document("\(user?.email ?? "")").setData([
     
     "isAdmin" : false,
     "userNickname":  "\(convertNickname(id: user?.email ?? ""))",
     "bookmarked": [],
     "createdVoca": [],
     "userId": "\(user?.email ?? "")",
     "email" : "\(user?.email ?? "")"
     ]) { err in
     if let err = err {
     print("Error writing document: \(err)")
     } else {
     print("Document successfully written!")
     }
     }
     }
     */
    
    //MARK: - ID 값을 받아 문자열 가공 후 nickname으로 설정
    func convertNickname(id: String) -> String {
        
        //  var id: String = id
        
        //        user.userId = id
        //
        //        return user.userId.components(separatedBy: "@")[0]
        return ""
    }
    
    /*
     func getCurrentUser() -> String {
     
     let user = Auth.auth().currentUser
     
     return user?.email ?? "default@test.com"
     }
     */
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
            if let error = err{
                print(error.localizedDescription)
                return
            }
        }
        
        print("Logged In")
        
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
                    fatalError(
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
