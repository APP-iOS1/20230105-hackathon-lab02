import SwiftUI

struct MainView: View {
    
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
                Color.mint
                    .edgesIgnoringSafeArea(.all)
                
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
    }
}

struct ToolbarModifier: ViewModifier {
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var vocabularyNetworkManager: VocabularyNetworkManager
    
    @Binding var searchText: String
    @State var isSignedIn: Bool = false
    @State var showingSignInAlert: Bool = false
    @State var isShowingSheet = false
    
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
                    }
                    NavigationLink {
                        SlangRegistrationView()
                    } label: {
                        Image(systemName: "plus.rectangle.portrait.fill")
                    }
//                    Button {
//                        isSignedIn = authManager.state == .signedOut ? false : true
//                        showingSignInAlert = !isSignedIn
//                    } label: {
//                        Image(systemName: "plus.rectangle.portrait.fill")
//                    }
//                    .navigationDestination(isPresented: $isSignedIn) {
//                        SlangRegistrationView()
//                    }
//                    .alert("로그인이 필요합니다", isPresented: $showingSignInAlert) {
//                        Button {
//                            print("취소")
//                        } label: {
//                            Text("취소")
//                        }
//                        Button {
//                            isShowingSheet = true
//                        } label: {
//                            Text("로그인")
//                        }
//                    }
//                    .sheet(isPresented: $isShowingSheet) {
//                        LoginView(isShowingSheet: $isShowingSheet)
//                    }
                    NavigationLink {
                        MyPageView()
                    } label: {
                        Image(systemName: "person.circle.fill")
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
