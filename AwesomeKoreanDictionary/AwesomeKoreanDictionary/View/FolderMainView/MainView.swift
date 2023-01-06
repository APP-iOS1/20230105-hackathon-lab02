import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @EnvironmentObject var vocabularyNetworkManager: VocabularyNetworkManager
    @EnvironmentObject var authManager: AuthManager
    
    @State private var searchText = ""
    
    var filteredVoca: [Vocabulary] {
        if searchText.isEmpty {
            return vocabularyNetworkManager.vocabularies.filter { $0.isApproved }
        } else {
            //            return dictionary.filter { $0.word.localizedStandardContains(searchText) }
            //            return dictionary.filter {
            //                $0.word.contains(searchText) }
            return vocabularyNetworkManager.vocabularies.filter {
                $0.word.contains(searchText) && $0.isApproved }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(hex: "737DFE"), Color(hex: "FFCAC9")]),
                               startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                //픽 [Color(hex: "FD80A8"), Color(hex: "FCCF42")]
                //   [Color(hex: "6D678E"), Color(hex: "F6B5CC")]
                // [Color(hex: "CCFBFF"), Color(hex: "EF96C5")]
                // [Color(hex: "EAE5C9"), Color(hex: "6CC6CB")]
                // [Color(hex: "737DFE"), Color(hex: "FFCAC9")]
                ScrollView {
                    Spacer(minLength: 10)
                    
                    VStack(spacing: 15) {
                        ForEach(filteredVoca, id: \.self) { vocabulary in
                            
                            ListCell(vocabulary: vocabulary)
                        }
                    }
                    
                    NavigationLink {
                        TestView()
                    } label: {
                        Text("테스트하러 가쟈")
                    }
 
                }
                .refreshable {
                    Task {
                        await vocabularyNetworkManager.requestVocabularyList()
                    }
                }
                .modifier(ToolbarModifier(searchText: $searchText))
            }
            .onAppear {
                Task {
                    await vocabularyNetworkManager.requestVocabularyList()
                    await vocabularyNetworkManager.countLikes()

                }
            }
            
        }
        .tint(.black)
    }
}

struct ToolbarModifier: ViewModifier {
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var vocabularyNetworkManager: VocabularyNetworkManager
    
    @Binding var searchText: String

    
    func body(content: Content) -> some View {
        content
            .toolbar {
                HStack {
                    SearchBar(searchText: $searchText)
                        .frame(width: 240)
                    NavigationLink {
                        QuizView()
                    } label: {
                        Image(systemName: "trophy.fill")
                            .foregroundColor(Color(hex: "292929"))
                    }
                    NavigationLink {
                        SlangRegistrationView()
                    } label: {
                        Image(systemName: "plus.rectangle.portrait.fill")
                            .foregroundColor(Color(hex: "292929"))
                    }

                    NavigationLink {
                        MyPageView()
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(Color(hex: "292929"))
                            .font(.title3)
                    }
                }
                .foregroundColor(.black)
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AuthManager())
            .environmentObject(VocabularyNetworkManager())
    }
}
