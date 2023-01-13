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
    //    let currentUserId = Auth.auth().currentUser?.uid ?? ""
    
    // MARK: - Firebase에 저장된 유저 값 가져오기 (로그인 시)
    // 뷰에서 닉네임을 불러올 때 쓰일 값
    /// uid 값을 통해 database의 특정 uid에 저장된 userNickname을 요청합니다.
    ///  - Parameter uid : currentUser의 UID
    ///  - Returns : currentUser의 userNickname
//    private func requestUserNickname(uid: String) async -> String {
//        var retValue = ""
//        return await withCheckedContinuation({ continuation in
//            database.collection("User").document(Auth.auth().currentUser?.uid ?? "").getDocument { (document, error) in
//                if let document = document, document.exists {
//                    retValue = document.get("userNickname") as! String
//                    continuation.resume(returning: retValue)
//                } else {
//                    print("2-")
//                    continuation.resume(throwing: error as! Never)
//                }
//            }
//        })
//    }
    
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
    
    public func updateUserNickName(id: String, nickname: String) async -> Void {
        //        guard let currentUserId else { return }
        let path = database.collection("user")
        do {
            try await path.document(id).updateData(["userNickname": nickname])
        } catch {
            print(error.localizedDescription)
        }
    }
    
}


