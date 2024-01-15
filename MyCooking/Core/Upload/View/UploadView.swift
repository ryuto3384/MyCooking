//
//  UploadView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI
import PhotosUI

struct UploadView: View {
    
    @State private var introduction = ""
    @State private var imagePickerPresented = false
    @State private var photoItem: PhotosPickerItem?
    
    @State private var title = ""
    @State private var methodValues: [String] = [""]
    
    @State private var ingredientsPeople = ""
    @State private var ingredientsValues: [String] = [""]
    @State private var ingredientsAmount: [String] = [""]
    
    
    @StateObject var viewModel = UploadViewModel()
    
    @Binding var tabIndex: Int
    let user: User
    
    @State private var showAlert = false
    
    @State private var selectedCategory = RecipeCategory.breakfast
    let categories = RecipeCategory.allCases
    
    var body: some View {
        VStack {
            //ツールバー
            HStack {
                Button {
                    clearPostDateAndReturnToFeed()
                } label: {
                    Text("閉じる")
                    
                }
                
                Spacer()
                Text("レシピを書く")
                    .fontWeight(.semibold)
                Spacer()
                
                Button {
                    if viewModel.postImage != nil {
                        if title.isEmpty || methodValues.allSatisfy({ $0.isEmpty }) || ingredientsValues.allSatisfy({ $0.isEmpty }) || ingredientsAmount.allSatisfy({ $0.isEmpty }) || introduction.isEmpty {
                            
                            showAlert = true
                        } else {
                            Task {
                                try await viewModel.uploadPost(title: title, introduction: introduction, methodValues: methodValues ,ingredientsPeople: ingredientsPeople, ingredientsValues: ingredientsValues, ingredientsAmount: ingredientsAmount, category: selectedCategory.rawValue)
                                clearPostDateAndReturnToFeed()
                                
                                try await viewModel.updateCount(user: user)
                            }
                            
                        }
                    } else {
                        showAlert = true
                    }
                    
                } label: {
                    Text("投稿")
                        .fontWeight(.semibold)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("入力エラー"), message: Text("全ての項目を入力してください"), dismissButton: .default(Text("OK")))
                }
            }
            .padding(.horizontal)
            
            
            ScrollView {
                VStack{
                    //画像配置
                    if let image = viewModel.postImage {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .clipped()
                    } else {
                        //ここの画像はあとから料理のイメージのものにする
                        Button {
                            imagePickerPresented.toggle()
                        }label: {
                            Image(.syumagi1)
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
                    
                    Picker("カテゴリー選択", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text("\(category.rawValue)").tag(category)
                        }
                    }
                    
                    
                }
                
                
            }
            
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
    
    func clearPostDateAndReturnToFeed() {
        introduction = ""
        title = ""
        ingredientsPeople = ""
        methodValues = [""]
        ingredientsValues = [""]
        ingredientsAmount = [""]
        viewModel.postImage = nil
        viewModel.selectedImage = nil
        selectedCategory = RecipeCategory.breakfast
        tabIndex = 2
    }
    
}

#Preview {
    UploadView(tabIndex: .constant(0), user: User.MOCK_USERS[0])
}
