import SwiftUI

struct HomeScreen: View {
    @State private var text: String = ""
    let dummyRecipes = [
        ShishaRecipe(id: 1, title: "フルーツミックス", ingredients: "りんご, オレンジ, ストロベリー, ミント", poster: "シーシャマスター", imageURL: "https://example.com/fruit-mix.jpg"),
        ShishaRecipe(id: 2, title: "チョコレートデライト", ingredients: "チョコレート, バニラ, キャラメル", poster: "スイーツラバー", imageURL: "https://example.com/chocolate-delight.jpg"),
        ShishaRecipe(id: 3, title: "トロピカルブリーズ", ingredients: "パイナップル, ココナッツ, マンゴー", poster: "ビーチボーイ", imageURL: "https://example.com/tropical-breeze.jpg"),
        ShishaRecipe(id: 4, title: "スパイシーチャイ", ingredients: "シナモン, カルダモン, クローブ, ジンジャー", poster: "スパイスガール", imageURL: "https://example.com/spicy-chai.jpg"),
        ShishaRecipe(id: 5, title: "メンソールフレッシュ", ingredients: "ペパーミント, ユーカリ, メンソール", poster: "クールキャット", imageURL: "https://example.com/menthol-fresh.jpg")
    ]
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                SearchBar(text: $text)
                    .padding()
                
                Text("人気のレシピ一覧")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                RecipeListView(recipes: dummyRecipes)
                    .padding()
                
                Text("過去に閲覧したレシピ")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                RecipeListView(recipes: dummyRecipes)
                    .padding()
                
                Spacer()
            }
        }
    }
}
