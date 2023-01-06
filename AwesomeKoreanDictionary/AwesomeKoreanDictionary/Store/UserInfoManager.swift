//
//  UserInfoManager.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/06.
//

import SwiftUI

import Firebase
import FirebaseFirestore
import FirebaseAuth

final class UserInfoManager: ObservableObject {
    @Published var userInfo: User?
    let database = Firestore.firestore()
    let currentUserId = Auth.auth().currentUser?.uid ?? ""
    
    @MainActor
    public func fetchUserInfo() {
        database.collection("user").getDocuments { snapshot, error in
            if let snapshot {
                
                for document in snapshot.documents {
                    let id : String = document.documentID
                    let docData = document.data()
                    
                    if id == self.currentUserId {
                        
                        let id = document.documentID
                        let isAdmin = docData["isAdmin"] as? Bool ?? false
                        let userNickname = docData["userNickname"] as? String ?? ""
                        let userEmail = docData["userEmail"] as? String ?? ""
                        
                        self.userInfo =
                        User(id: id, isAdmin: isAdmin, userNickname: userNickname, userEmail: userEmail)
                        
                        print(self.userInfo!)
                    }
                }
                
            }
        }
    }
    
    //    @MainActor
    //    public func requestCurrentUserInfo() async -> Void {
    //        do{
    //            let document = try await
    //            database.collection("user").getDocument(currentUserId)
    //
    //            let id = document.documentID
    //            let isAdmin = document.isAdmin as? Bool ?? false
    //            let userNickname = document.userNickname as? String ?? ""
    //            let userEmail = document.userEmail as? String ?? ""
    //
    //            userInfo = document
    //
    //            print("\(userInfo)")
    //        } catch {
    //            print(error.localizedDescription)
    //        }
    //    }
    
    // MARK: - 유저 닉네임 변경 업데이트 함수
    @MainActor
    public func updateUserNickName(nickname: String) async -> Void {
//        guard let currentUserId else { return }
        let path = database.collection("user")
        do {
            try await path.document(currentUserId).setData(["userNickname": nickname], merge: true)
        } catch {
            print(error.localizedDescription)
        }
    }
}
