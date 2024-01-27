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
    
    @ObservedObject var viewModel: ShowRecipeViewModel
    
    @State private var imagePickerPresented = false
    @State private var photoItem: PhotosPickerItem?
    
    @State private var showAlert = false
    
    @State private var selectedCategory = [String]()
    
    init(viewModel: ShowRecipeViewModel) {
        self.viewModel = viewModel
    }
    
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
                            try await viewModel.updateRecipe()
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
                    if let image = viewModel.postImage {
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
                            KFImage(URL(string: viewModel.imageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 300)
                                .clipped()
                            //画像に白いフィルターを付ける
                        }
                        
                        
                    }
                    //区切り線
                    Divider()
                    TextField("タイトル", text: $viewModel.title)
                        .padding(.top, 20)
                        .padding(.horizontal, 10)
                    Divider()
                    
                    VStack {
                        Text("作り方")
                            .font(.title2)
                        
                        ForEach(0..<viewModel.methodValues.count, id: \.self) { index in
                            VStack{
                                HStack{
                                    Text("\(index + 1)")
                                        .frame(width: 20, height: 20)
                                    TextField("野菜を切る", text: $viewModel.methodValues[index], axis: .vertical)
                                }
                                Divider()
                            }
                            
                        }
                        
                        HStack{
                            Text("+")
                                .font(.title)
                            Button("作り方を追加"){
                                viewModel.methodValues.append("")
                            }
                            
                        }
                        
                        
                    }
                    .padding(10)
                    
                    VStack{
                        Text("材料")
                            .font(.title2)
                        
                        TextField("2人分", text: $viewModel.ingredientsPeople)
                        ForEach(0..<viewModel.ingredientsValues.count, id: \.self) { index in
                            HStack{
                                TextField("食材",text: $viewModel.ingredientsValues[index])
                                TextField("〇g", text: $viewModel.ingredientsAmount[index])
                            }
                        }
                        
                        HStack{
                            Text("+")
                                .font(.title)
                            Button("食材を追加"){
                                viewModel.ingredientsValues.append("")
                                viewModel.ingredientsAmount.append("")
                            }
                            
                        }
                    }
                    .padding(10)
                    
                    TextField("レシピの紹介文", text: $viewModel.introduction, axis: .vertical)
                        .padding(10)
                    
                    UploadHashView(selectedTags: $viewModel.selectedCategory)
                    
                    
                }
                
                
            }
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
        
        
    }
    
    
}

#Preview {
    RecipeEditView(viewModel: ShowRecipeViewModel(post: Post.MOCK_POSTS[1], user: User.MOCK_USERS[0]))
}
