import SwiftUI

struct MainView: View {
    
    @State private var searchText = "Search"
    @State var isShowingSheet = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.mint
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    Spacer(minLength: 10)
                    VStack(spacing: 15) {
                        ForEach(dictionary, id: \.self) { vocabulary in
                            ListCell(vocabulary: vocabulary)
                        }
                    }
                    NavigationLink {
                        Text("")
                    } label: {
                        TextField(text: $searchText) {
                            Text("hello")
                        }
                    }

//                    .fullScreenCover(isPresented: $isShowingSheet) {
//                    Text("hello")
//                    }
                }
                .scrollContentBackground(.hidden)
                .toolbar {
                    HStack {
//                        SearchBar(searchText: $searchText, isShowingSheet: $isShowingSheet)
//                            .frame(width: 240)
//
//                        Text("Awesome")
//                            .font(.largeTitle)
//                            .fontWeight(.bold)
//                        
                        NavigationLink {
                            SearchView()
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }
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
                            MyPageView_SignOut()
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
