import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeScreen()
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("ホーム")
                }
            
            RecipePostScreen()
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("投稿")
                }
            
            ProfileScreen()
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("マイページ")
                }
        }
    }
}
