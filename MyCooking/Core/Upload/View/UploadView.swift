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
    
    @State private var titleText = ""
    @State private var methodValue = 1
    @State private var methodValues: [String] = Array(repeating: "", count: 100)
    
    @State private var ingredientsPeople = ""
    @State private var ingredientsValue = 3
    @State private var ingredientsValues: [String] = Array(repeating: "", count: 100)
    @State private var ingredientsAmount: [String] = Array(repeating: "", count: 100)
    
    
    @StateObject var viewModel = UploadViewModel()
    
    @Binding var tabIndex: Int
    
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
                    Task {
                        try await viewModel.uploadPost(caption: introduction)
                        clearPostDateAndReturnToFeed()
                    }
                } label: {
                     Text("投稿")
                        .fontWeight(.semibold)
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
                    TextField("タイトル", text: $titleText)
                        .padding(.top, 20)
                        .padding(.horizontal, 10)
                    Divider()
                    
                    VStack {
                        Text("作り方")
                            .font(.title2)
                        
                        ForEach(1...methodValue, id: \.self) { index in
                            VStack{
                                HStack{
                                    Text("\(index)")
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
                                methodValue += 1
                            }
                        
                        }
                        
                        
                    }
                    .padding(10)
                    
                    VStack{
                        Text("材料")
                            .font(.title2)
                        
                        TextField("2人分", text: $ingredientsPeople)
                        ForEach(1...ingredientsValue, id: \.self) { index in
                            HStack{
                                TextField("食材",text: $ingredientsValues[index])
                                TextField("〇g", text: $ingredientsAmount[index])
                            }
                        }
                        
                        HStack{
                            Text("+")
                                .font(.title)
                            Button("食材を追加"){
                                ingredientsValue += 1
                            }
                        
                        }
                    }
                    .padding(10)
                    
                    TextField("レシピの紹介文", text: $introduction, axis: .vertical)
                        .padding(10)
                    
                    
                    
                }
                
                
            }

        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
    
    func clearPostDateAndReturnToFeed() {
        introduction = ""
        viewModel.postImage = nil
        viewModel.selectedImage = nil
        tabIndex = 2
    }
    
}

#Preview {
    UploadView(tabIndex: .constant(0))
}
