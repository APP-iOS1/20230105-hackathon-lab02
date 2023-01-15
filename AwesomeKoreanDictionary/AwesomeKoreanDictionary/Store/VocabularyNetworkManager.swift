//
//  VocabularyNetworkManager.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/05.
//

import SwiftUI

import Firebase
import FirebaseFirestore


struct Likes: Hashable, Identifiable {
    var id: String
    var likeCount: Int
    var dislikeCount: Int
}

/*
 
 likes 컬렉션의 문서는 보카의 아이디.
 해당 아이디로 들어가면 likeArray가 있고, 그걸 좋아요하면
 좋아요한 currentUid가 likeArray에 들어간다.
 그래서 countLikes 메소드를 사용해서 개수를 알아오고
 그 개수를 해당 voca에 좋아요 개수에 반영해준다.
 
 likes 배열이 있다이가. 근데 얘네는 게시물의 id를 갖고있다이가
 뿌려줄때 같은 id갖은애가 있따? 그러면 걔한테 count를 넣어주자
 */

final class VocabularyNetworkManager: ObservableObject {

    @Published var vocabularies: [Vocabulary] = []
    @Published var cards: [Card] = []
    @Published var likes: [Likes] = []
    
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
                let likes = document["likes"] as? Int ?? 0
                let dislikes = document["dislikes"] as? Int ?? 0
                let creatorId = document["creatorId"] as? String ?? ""
                let isApproved = document["isApproved"] as? Bool ?? false
                self.vocabularies.append(Vocabulary(id: id, word: word, pronunciation: pronunciation, definition: definition, example: example, likes: likes, dislikes: dislikes, creatorId: creatorId, isApproved: isApproved))
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    @MainActor
    func countLikes() async -> Void {
        do {
            let documents = try await
            database.collection("likes").getDocuments()
            
            self.likes.removeAll()
            for document in documents.documents {
                let id = document.documentID
                let likeArray: [String] = document["likeArray"] as? [String] ?? []
                let dislikeArray: [String] = document["dislikeArray"] as? [String] ?? []

                self.likes.append(Likes(id: id, likeCount: likeArray.count, dislikeCount: dislikeArray.count))
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
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
                "likes": voca.likes,
                "dislikes": voca.dislikes,
                "creatorId": voca.creatorId,
                "isApproved": voca.isApproved
                ])
            
            try await database.collection("likes").document(voca.id).setData([
                "id": voca.id,
                "likeArray": [],
                "dislikeArray": []
                ])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func addLikes(voca: Vocabulary) async -> Void {
        let path = database.collection("likes")
        do {
            try await path.document(voca.id).updateData([
                "likeArray": FieldValue.arrayUnion(["\(currentUserId)"])
                ])
        } catch {
            print(error.localizedDescription)
        }
    }
    public func addDisLikes(voca: Vocabulary) async -> Void {
        let path = database.collection("likes")
        do {
            try await path.document(voca.id).updateData([
                "dislikeArray": FieldValue.arrayUnion(["\(currentUserId)"])
                ])
        } catch {
            print(error.localizedDescription)
        }
    }
    

//    public func removeLikes(voca: Vocabulary) async -> Void {
//        let path = database.collection("likes")
//        do {
//            try await path.document(voca.id).updateData([
//                "좋아요개수": FieldValue.arrayRemove(["헬로우"])
//                ])
//            print("좋아요빼기")
//        } catch {
//            print(error.localizedDescription)
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
            print(error.localizedDescription)
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
                    //                let pronunciation = document["pronunciation"] as? String ?? ""
                    let definition = document["definition"] as? String ?? ""
                    //                let example = document["example"] as? String ?? []
                    //                let likes = document["likes"] as? Int ?? 0
                    //                let dislikes = document["dislikes"] as? Int ?? 0
                    //                let creatorId = document["creatorId"] as? String ?? ""
                    let isApproved = document["isApproved"] as? Bool ?? false
                    
                    self.cards.append(Card(cardId: id, name: word, offset: 0, definition: definition))
                    count += 1
                }
            }
        } catch (let error) {
            print(error)
        }

    }


}
