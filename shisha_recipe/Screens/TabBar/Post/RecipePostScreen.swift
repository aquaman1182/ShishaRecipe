import SwiftUI
import PhotosUI

struct IngredientRow: View {
    @Binding var name: String
    @Binding var amount: String
    
    var body: some View {
        HStack {
            AppTextField(placeholder: "材料名", text: $name)
            AppTextField(placeholder: "量", text: $amount)
                .frame(width: 100)
        }
    }
}

struct TextButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "plus")
                Text(title)
                    .bold()
            }
            .foregroundColor(.purple)
        }
    }
}

struct RecipePostScreen: View {
    @State private var recipeName: String = ""
    @State private var ingredients: [(name: String, amount: String)] = [("", "")]
    @State private var steps: [String] = [""]
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    imageSection
                    recipeNameSection
                    ingredientsSection
                    stepsSection
                }
                .padding()
            }
            .navigationTitle("レシピを投稿")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("投稿", action: postRecipe)
                        .fontWeight(.bold)
                }
            }
        }
    }
    
    var imageSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("レシピ画像")
                .font(.headline)
            
            PhotosPicker(selection: $selectedItem, matching: .images) {
                if let selectedImageData,
                   let uiImage = UIImage(data: selectedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(8)
                } else {
                    ZStack {
                        Rectangle()
                            .fill(Color(.systemGray6))
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(8)
                        
                        Image(systemName: "camera")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                    }
                }
            }
            .onChange(of: selectedItem) { newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }
        }
    }
    
    var recipeNameSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("レシピ名")
                .font(.headline)
            AppTextField(placeholder: "レシピ名を入力", text: $recipeName)
        }
    }
    
    var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("材料")
                .font(.headline)
            ForEach(ingredients.indices, id: \.self) { index in
                IngredientRow(name: $ingredients[index].name, amount: $ingredients[index].amount)
            }
            HStack {
                Spacer()
                TextButton(title: "材料を追加") {
                    ingredients.append(("", ""))
                }
                Spacer()
            }
        }
    }
    
    var stepsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("作り方")
                .font(.headline)
            ForEach(steps.indices, id: \.self) { index in
                HStack(alignment: .center, spacing: 8) {
                    Text("\(index + 1):")
                        .font(.system(size: 16, weight: .bold))
                        .frame(width: 30, alignment: .trailing)
                    AppTextField(placeholder: "手順を入力", text: $steps[index])
                }
            }
            HStack {
                Spacer()
                TextButton(title: "手順を追加") {
                    steps.append("")
                }
                Spacer()
            }
        }
    }
    
    func postRecipe() {
        // ここにレシピを投稿するロジックを実装
        print("レシピ名: \(recipeName)")
        print("材料: \(ingredients)")
        print("手順: \(steps)")
        // 画像データの処理やAPIへの送信などを行う
        dismiss()
    }
}
