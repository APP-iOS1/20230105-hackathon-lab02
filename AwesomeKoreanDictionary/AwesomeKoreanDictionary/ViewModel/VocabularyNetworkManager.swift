//
//  VocabularyNetworkManager.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/05.
//

import SwiftUI
import Firebase
import FirebaseFirestore

//struct Likes: Hashable, Identifiable {
//    var id: String
//    var likeCount: Int
//    var dislikeCount: Int
//}

final class VocabularyNetworkManager: ObservableObject {
    
    @Published var vocabularies: [Vocabulary] = []
    @Published var cards: [Card] = []
    //    @Published var likes: [Likes] = []
    
    let database = Firestore.firestore()
    let currentUserId = Auth.auth().currentUser?.uid ?? ""
    
    //MARK: - 단어 리스트 불러오기(승인 된거 안된거 다 불러옴)
    @MainActor
    func requestVocabularyList() async -> Void {
        do {
            let documents = try await
            database.collection("vocabulary").getDocuments()
            
            self.vocabularies.removeAll()
            for document in documents.documents {
                let id = document.documentID
                let word = document["word"] as? String ?? ""
                let pronunciation = document["pronunciation"] as? String ?? ""
                let definition = document["definition"] as? String ?? ""
                let example = document["example"] as? String ?? ""
                let creatorId = document["creatorId"] as? String ?? ""
                let isApproved = document["isApproved"] as? Bool ?? false
                let likeArray = document["likeArray"] as? [String] ?? []
                let dislikeArray = document["dislikeArray"] as? [String] ?? []
                
                self.vocabularies.append(Vocabulary(id: id, word: word, pronunciation: pronunciation, definition: definition, example: example, likeArray: likeArray, dislikeArray: dislikeArray, creatorId: creatorId, isApproved: isApproved))
            }
        } catch {
#if DEBUG
            print("\(error.localizedDescription)")
#endif
        }
    }
    
    
    //    func countLikes() async -> Void {
    //        do {
    //            let documents = try await
    //            database.collection("likes").getDocuments()
    //            self.likes.removeAll()
    //            for document in documents.documents {
    //                let id = document.documentID
    //                let likeArray: [String] = document["likeArray"] as? [String] ?? []
    //                let dislikeArray: [String] = document["dislikeArray"] as? [String] ?? []
    //                self.likes.append(Likes(id: id, likeCount: likeArray.count, dislikeCount: dislikeArray.count))
    //            }
    //        } catch {
    //#if DEBUG
    //            print("\(error.localizedDescription)")
    //#endif
    //        }
    //    }
    
    
    //MARK: - 단어 생성 폼 제출 시 불러올 함수
    @MainActor
    public func createVoca(voca: Vocabulary) async -> Void {
        let path = database.collection("vocabulary")
        do {
            try await path.document(voca.id).setData([
                "id": voca.id,
                "word": voca.word,
                "pronunciation": voca.pronunciation,
                "definition": voca.definition,
                "example": voca.example,
                "creatorId": voca.creatorId,
                "isApproved": voca.isApproved,
                "likeArray": [],
                "dislikeArray": []
            ])
            
        } catch {
#if DEBUG
            print("\(error.localizedDescription)")
#endif
        }
    }
    public func updateFields(voca: Vocabulary) async -> Void {
        let path = database.collection("vocabulary")
        do {
            try await path.document(voca.id).updateData([
                "likeArray": [],
                "dislikeArray": []
            ])
        } catch {
#if DEBUG
            print("\(error.localizedDescription)")
#endif
        }
    }
    func tapLikeVoca(voca: Vocabulary) {
        Task {
            if voca.likeArray.contains(currentUserId) {
                try await database.collection("vocabulary").document(voca.id).updateData([
                    "likeArray": FieldValue.arrayRemove([currentUserId])
                ])
            } else {
                try await database.collection("vocabulary").document(voca.id).updateData([
                    "likeArray": FieldValue.arrayUnion([currentUserId]),
                    "dislikeArray": FieldValue.arrayRemove([currentUserId])
                ])
            }
        }
    }
    
    func tapDislikeVoca(voca: Vocabulary) {
        Task {
            if voca.dislikeArray.contains(currentUserId) {
                try await database.collection("vocabulary").document(voca.id).updateData([
                    "dislikeArray": FieldValue.arrayRemove([currentUserId])
                ])
            } else {
                try await database.collection("vocabulary").document(voca.id).updateData([
                    "likeArray": FieldValue.arrayRemove([currentUserId]),
                    "dislikeArray": FieldValue.arrayUnion([currentUserId])
                ])
            }
        }
    }
    
    
    //    public func addLikes(voca: Vocabulary) async -> Void {
    //        let path = database.collection("likes")
    //        do {
    //            try await path.document(voca.id).updateData([
    //                "likeArray": FieldValue.arrayUnion(["\(currentUserId)"])
    //            ])
    //        } catch {
    //#if DEBUG
    //            print("\(error.localizedDescription)")
    //#endif
    //        }
    //    }
    //    public func addDisLikes(voca: Vocabulary) async -> Void {
    //        let path = database.collection("likes")
    //        do {
    //            try await path.document(voca.id).updateData([
    //                "dislikeArray": FieldValue.arrayUnion(["\(currentUserId)"])
    //            ])
    //        } catch {
    //#if DEBUG
    //            print("\(error.localizedDescription)")
    //#endif
    //        }
    //    }
    
    //MARK: - 등록 신청된 단어 승인 함수
    @MainActor
    public func updateVocaApproved(voca: Vocabulary) async -> Void {
        let path = database.collection("vocabulary")
        do {
            try await path.document(voca.id).setData([
                "isApproved": true
            ], merge: true)
        } catch {
#if DEBUG
            print("\(error.localizedDescription)")
#endif
        }
    }
    
    // MARK: - Vocabulary를 가져와서 Card로 만들어주는 함수
    @MainActor
    public func vocabularyToCard() async -> Void {
        do {
            let documents = try await database.collection("vocabulary")
                .whereField("isApproved", isEqualTo: true)
                .getDocuments()
            
            self.cards.removeAll()
            var count = 0
            
            let shuffledDoc = documents.documents.shuffled()
            
            for (idx, document) in shuffledDoc.enumerated() {
                if idx < 7 {
                    let id = count
                    let word = document["word"] as? String ?? ""
                    
                    let definition = document["definition"] as? String ?? ""
                    let isApproved = document["isApproved"] as? Bool ?? false
                    
                    self.cards.append(Card(cardId: id, name: word, offset: 0, definition: definition))
                    count += 1
                }
            }
        } catch (let error) {
#if DEBUG
            print("\(error.localizedDescription)")
#endif
        }
        
    }
    
    
}
