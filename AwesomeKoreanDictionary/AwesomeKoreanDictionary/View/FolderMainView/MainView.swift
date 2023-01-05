import SwiftUI

struct MainView: View {
    
    @State private var searchText = ""
    @State var isShowingSheet = false
    @State var isShowingPopover = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.mint
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    Spacer(minLength: 10)
                    VStack(spacing: 15) {
                        ForEach(dictionary, id: \.self) { vocabulary in
                            ListCell(vocabulary: vocabulary, isShowingPopover: $isShowingPopover)
                        }
                    }
//                    .fullScreenCover(isPresented: $isShowingSheet) {
//                    Text("hello")
//                    }
                }
                
                .scrollContentBackground(.hidden)
                .toolbar {
                    HStack {
                        SearchBar(searchText: $searchText, isShowingSheet: $isShowingSheet)
                            .frame(width: 240)
                        
                        NavigationLink {
                            Text("Quiz")
                        } label: {
                            Image(systemName: "trophy.fill")
                        }
                        NavigationLink {
                            Text("추가")
                        } label: {
                            Image(systemName: "plus.rectangle.portrait.fill")
                        }
                        NavigationLink {
                            Text("마이페이지")
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
    }
}
