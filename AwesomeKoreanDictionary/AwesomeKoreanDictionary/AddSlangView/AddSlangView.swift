//
//  AddSlangView.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/14.
//

import SwiftUI

struct AddSlangView: View {
    @EnvironmentObject var vocabularyManager: VocabularyNetworkManager

    var body: some View {
        ForEach(array, id: \.self) { voc in
            Button {
                Task {
                 await vocabularyManager.createVoca(voca: voc)
                }
            } label: {
                Text(voc.word)
            }

        }    }
}



var array: [Vocabulary] = [


    Vocabulary(id: UUID().uuidString, word: "츤데레", pronunciation: "[cheundere]", definition: "쌀쌀맞고 까칠해보이지만, 사실상은 따뜻하고 다정한 사람을 이르는 말", example: "남자친구가 오다 주웠다고 선물을 줬어. 완전 츤데레야.", likes: 0, dislikes: 0, creatorId: "yooj", isApproved: true),
    
    
   


]

struct AddSlangView_Previews: PreviewProvider {
    static var previews: some View {
        AddSlangView()
            .environmentObject(VocabularyNetworkManager())
       
        
    }
}
