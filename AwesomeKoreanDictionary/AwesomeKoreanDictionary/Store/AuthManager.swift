//
//  AuthManager.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/05.
//

import Firebase
import FirebaseFirestore
import GoogleSignIn

class AuthManager: ObservableObject {
    
    enum signInState {
        case signedIn
        case signedOut
    }
    var googleUser: GIDGoogleUser?
    @Published var state: signInState = .signedOut
    @Published var currentUser = GIDSignIn.sharedInstance.currentUser
    
    //  -----
    @Published var user: User = User(id: "", isAdmin: false, userNickname: "", userEmail: "")
    //    User(isAdmin: false, userNickname: "", bookmarked: [], createdVoca: [], userId: "", email: "")
    
    func signIn() {
        // You check if there’s a previous Sign-In. If yes, then restore it. Otherwise, move on to defining the sign-in process.
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error)
            }
        } else {
            // Get the clientID from Firebase App. It fetches the clientID from the GoogleService-Info.plist added to the project earlier.
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            // Create a Google Sign-In configuration object with the clientID.
            
            //            let configuration = GIDConfiguration(clientID: clientID)
            
            // As you’re not using view controllers to retrieve the presentingViewController, access it through the shared instance of the UIApplication. Note that directly using the UIWindow is now deprecated, and you should use the scene instead.
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            // Then, call signIn() from the shared instance of the GIDSignIn class to start the sign-in process. You pass the configuration object and the presenting controller.
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
                if let googleUser = result?.user {
                    self.googleUser = googleUser
                    
                    let db = Firestore.firestore()
                    let userRef = db.collection("user").document(googleUser.userID ?? "")
                    
                    userRef.getDocument {
                        (document, error) in
                        if let document = document, document.exists {
                            // 이미 저장된 유저 정보
                            userRef.updateData([
                                "id": googleUser.userID ?? "",
//                                "isAdmin": false,
                                "userEmail": googleUser.profile?.email as? String ?? "",
                                "userNickname": googleUser.profile?.name as? String ?? ""
                            ])
                        } else {
                            // 저장되지 않은 유저 정보
                            userRef.setData([
                                "id": googleUser.userID ?? "",
                                "isAdmin": false,
                                "userEmail": googleUser.profile?.email ?? "",
                                "userNickname": googleUser.profile?.name ?? ""
                            ], merge: true)
                        }
                    }
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
    
    func signOut() {
        // 1
        GIDSignIn.sharedInstance.signOut()
        
        do {
            // 2
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
}
