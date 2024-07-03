import SwiftUI

struct RecipeListView: View {
    let recipes: [ShishaRecipe]
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(recipes) { recipe in
                    RecipeCardView(recipe: recipe)
            }
        }
    }
}
