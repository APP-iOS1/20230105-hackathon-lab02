//
//  VocabularyNetworkManager.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/05.
//

import SwiftUI

import Firebase
import FirebaseFirestore

final class VocabularyNetworkManager: ObservableObject {

    @Published var vocabularies: [Vocabulary] = []
    @Published var cards: [Card] = []

    let database = Firestore.firestore()

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
            print("\(vocabularies)")
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
                    "likeArray": []
                    ])
            } catch {
                print(error.localizedDescription)
            }
        }


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

//        let path = database.collection("vocabulary")

        do {

            let documents = try await database.collection("vocabulary").getDocuments()
            self.cards.removeAll()
            var count = 0

            for document in documents.documents {

                let id = count
                let word = document["word"] as? String ?? ""
//                let pronunciation = document["pronunciation"] as? String ?? ""
                let definition = document["definition"] as? String ?? ""
//                let example = document["example"] as? String ?? []
//                let likes = document["likes"] as? Int ?? 0
//                let dislikes = document["dislikes"] as? Int ?? 0
//                let creatorId = document["creatorId"] as? String ?? ""
                let isApproved = document["isApproved"] as? Bool ?? false
                if isApproved {
                    self.cards.append(Card(cardId: id, name: word, offset: 0, definition: definition))
                    count += 1
                }
            }
//            try await
        } catch (let error) {
            print(error)
        }


    }


}
