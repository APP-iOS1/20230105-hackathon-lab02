import SwiftUI

struct MainView: View {
    
    @State private var searchText = ""
//    @State var isShowingSheet = false
    var filteredVoca: [Vocabulary] {
        if searchText.isEmpty {
            return dictionary
        } else {
            //            return dictionary.filter { $0.word.localizedStandardContains(searchText) }
            return dictionary.filter { $0.word.contains(searchText) }
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
                }
                .refreshable {
                    ProgressView()
                }
                .toolbar {
                    HStack {
                        SearchBar(searchText: $searchText)
                            .frame(width: 240)

//                        Text("Awesome")
//                            .font(.largeTitle)
//                            .fontWeight(.bold)
//
//                        NavigationLink {
//                            SearchView()
//                        } label: {
//                            Image(systemName: "magnifyingglass")
//                        }
                        NavigationLink {
                            QuizCardView()
                        } label: {
                            Image(systemName: "trophy.fill")
                        }
                        NavigationLink {
                            RegistrationView()
                        } label: {
                            Image(systemName: "plus.rectangle.portrait.fill")
                        }
                        NavigationLink {
                            MyPageView()

                        } label: {
                            Image(systemName: "person.circle.fill")
                        }
                    }
                }
            }
            
        }
    }
}




struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(CardModel())
    }
}
