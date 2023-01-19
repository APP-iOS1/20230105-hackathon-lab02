//
//  TextView.swift
//  AwesomeKoreanDictionary
//
//  Created by TAEHYOUNG KIM on 2023/01/20.
//

import SwiftUI

struct TextView: View {
    @EnvironmentObject var vm: VocabularyNetworkManager
    var body: some View {
        
        VStack {
            List(vm.vocabularies) { voca in
                VStack{
                    Text(voca.word)
                    Button {
                        Task {
                            await vm.updateFields(voca: voca)
                        }
                    } label: {
                        Text("Make Like & Dislike Array in VocabularyStructure")
                    }
                }
            }
        }
        .onAppear {
            Task {
               await vm.requestVocabularyList()
            }
        }
        
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
            .environmentObject(VocabularyNetworkManager())
    }
}
