//
//  RecipeEditView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/27.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct RecipeEditView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var viewModel: MainTabViewModel
    @ObservedObject var recipeModel: ShowRecipeViewModel
    
    @State private var imagePickerPresented = false
    @State private var photoItem: PhotosPickerItem?
    
    @State private var showAlert = false
    
    @State private var selectedCategory = [String]()

    
    var body: some View {
        
        VStack {
            //toolbar
            VStack {
                HStack {
                    Button("閉じる") {
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Text("レシピ編集")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button {
                        Task {
                            try await recipeModel.updateRecipe()
                            try await viewModel.fetchAllPosts()
                        }
                        dismiss()
                        
                    } label: {
                        Text("完了")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
                .padding(.top, 15)
                .padding(.bottom)
                .padding(.horizontal)
                
                //Divider()
            }
            
            //レシピ
            ScrollView {
                VStack{
                    //画像配置
                    if let image = recipeModel.postImage {
                        Button {
                            imagePickerPresented.toggle()
                        }label: {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 300)
                                .clipped()
                            //画像に白いフィルターを付ける
                        }
                        
                    } else {
                        Button {
                            imagePickerPresented.toggle()
                        }label: {
                            KFImage(URL(string: recipeModel.imageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 300)
                                .clipped()
                            //画像に白いフィルターを付ける
                        }
                        
                        
                    }
                    //区切り線
                    Divider()
                    TextField("タイトル", text: $recipeModel.title)
                        .padding(.top, 20)
                        .padding(.horizontal, 10)
                    Divider()
                    
                    VStack {
                        Text("作り方")
                            .font(.title2)
                        
                        ForEach(0..<recipeModel.methodValues.count, id: \.self) { index in
                            VStack{
                                HStack{
                                    Text("\(index + 1)")
                                        .frame(width: 20, height: 20)
                                    TextField("野菜を切る", text: $recipeModel.methodValues[index], axis: .vertical)
                                }
                                Divider()
                            }
                            
                        }
                        
                        HStack{
                            Text("+")
                                .font(.title)
                            Button("作り方を追加"){
                                recipeModel.methodValues.append("")
                            }
                            
                        }
                        
                        
                    }
                    .padding(10)
                    
                    VStack{
                        Text("材料")
                            .font(.title2)
                        
                        TextField("2人分", text: $recipeModel.ingredientsPeople)
                        ForEach(0..<recipeModel.ingredientsValues.count, id: \.self) { index in
                            HStack{
                                TextField("食材",text: $recipeModel.ingredientsValues[index])
                                TextField("〇g", text: $recipeModel.ingredientsAmount[index])
                            }
                        }
                        
                        HStack{
                            Text("+")
                                .font(.title)
                            Button("食材を追加"){
                                recipeModel.ingredientsValues.append("")
                                recipeModel.ingredientsAmount.append("")
                            }
                            
                        }
                    }
                    .padding(10)
                    
                    TextField("レシピの紹介文", text: $recipeModel.introduction, axis: .vertical)
                        .padding(10)
                    
                    UploadHashView(selectedTags: $recipeModel.selectedCategory)
                    
                    
                }
                
                
            }
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $recipeModel.selectedImage)
        
        
    }
    
    
}

#Preview {
    RecipeEditView(recipeModel: ShowRecipeViewModel(post: Post.MOCK_POSTS[0], curUser: User.MOCK_USERS[0]))
}
