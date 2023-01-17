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
    
    @MainActor
    public func fetchUserInfo(userId: String) async -> Void {
        let path = database.collection("user")
        await withCheckedContinuation({ continuation in
            path.getDocuments { (snapshot, error) in
            if let snapshot {
                for document in snapshot.documents {
                    let id : String = document.documentID
                    let docData = document.data()
                    if id == userId {
                        
                        let id = document.documentID
                        let isAdmin = docData["isAdmin"] as? Bool ?? false
                        let userNickname = docData["userNickname"] as? String ?? ""
                        let userEmail = docData["userEmail"] as? String ?? ""
                        
                        self.userInfo =
                        User(id: id, isAdmin: isAdmin, userNickname: userNickname, userEmail: userEmail)
                        
                        continuation.resume()
                        print(self.userInfo!)
                    }
                }
            } else {
                continuation.resume(throwing: error as! Never)
            }
        }
        })
    }
    
    // MARK: - 유저 닉네임 변경 업데이트 함수

    @MainActor
    
    public func updateUserNickName(id: String, nickname: String) async -> Void {
        //        guard let currentUserId else { return }
        let path = database.collection("user")
        do {
            try await path.document(id).updateData(["userNickname": nickname])
        } catch {
#if DEBUG
            print("\(error.localizedDescription)")
#endif
        }
    } 
}


