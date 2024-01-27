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
    
    @State private var introduction = ""
    @State private var imagePickerPresented = false
    @State private var photoItem: PhotosPickerItem?
    
    @State private var title = ""
    @State private var methodValues: [String] = [""]
    
    @State private var ingredientsPeople = ""
    @State private var ingredientsValues: [String] = [""]
    @State private var ingredientsAmount: [String] = [""]
    
    @State private var showAlert = false
    
    @State private var selectedCategory = [String]()
    
    @State private var imageURL = ""
    
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
                            try await /*viewModel.updateUserData()*/
                            dismiss()
                        }
                        
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
                        //ここの画像はあとから料理のイメージのものにする
                        Button {
                            imagePickerPresented.toggle()
                        }label: {
                            KFImage(URL(string: imageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 300)
                                .clipped()
                            //画像に白いフィルターを付ける
                        }
                        
                        
                    }
                    //区切り線
                    Divider()
                    TextField("タイトル", text: $title)
                        .padding(.top, 20)
                        .padding(.horizontal, 10)
                    Divider()
                    
                    VStack {
                        Text("作り方")
                            .font(.title2)
                        
                        ForEach(0..<methodValues.count, id: \.self) { index in
                            VStack{
                                HStack{
                                    Text("\(index + 1)")
                                        .frame(width: 20, height: 20)
                                    TextField("野菜を切る", text: $methodValues[index], axis: .vertical)
                                }
                                Divider()
                            }
                            
                        }
                        
                        HStack{
                            Text("+")
                                .font(.title)
                            Button("作り方を追加"){
                                methodValues.append("")
                            }
                            
                        }
                        
                        
                    }
                    .padding(10)
                    
                    VStack{
                        Text("材料")
                            .font(.title2)
                        
                        TextField("2人分", text: $ingredientsPeople)
                        ForEach(0..<ingredientsValues.count, id: \.self) { index in
                            HStack{
                                TextField("食材",text: $ingredientsValues[index])
                                TextField("〇g", text: $ingredientsAmount[index])
                            }
                        }
                        
                        HStack{
                            Text("+")
                                .font(.title)
                            Button("食材を追加"){
                                ingredientsValues.append("")
                                ingredientsAmount.append("")
                            }
                            
                        }
                    }
                    .padding(10)
                    
                    TextField("レシピの紹介文", text: $introduction, axis: .vertical)
                        .padding(10)
                    
                    UploadHashView(selectedTags: $selectedCategory)
                    
                    
                }
                
                
            }
        }
        .onAppear{
            loadDataFromViewModel()
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
    
    private func loadDataFromViewModel(){
        self.imageURL = viewModel.post.imageUrl
        self.introduction = viewModel.post.introduction
        self.title = viewModel.post.title
        self.methodValues = viewModel.post.methodValues
        self.ingredientsPeople = viewModel.post.ingredientsPeople
        self.ingredientsValues = viewModel.post.ingredientsValues
        self.ingredientsAmount = viewModel.post.ingredientsAmount
        self.selectedCategory = viewModel.post.category
    }
}

#Preview {
    RecipeEditView(viewModel: ShowRecipeViewModel(post: Post.MOCK_POSTS[1], user: User.MOCK_USERS[0]))
}
