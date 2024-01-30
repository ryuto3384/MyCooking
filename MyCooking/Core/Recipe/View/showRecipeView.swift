//
//  showRecipeView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/06.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct showRecipeView: View {
    
    @EnvironmentObject var viewModel: MainTabViewModel
    //レシピ用のインスタンス
    @StateObject var recipeModel: ShowRecipeViewModel
    
    let curCheck: Bool 
    
    init(post: Post, curUser: User, _ curCheck: Bool = false) {
        self._recipeModel = StateObject(wrappedValue: ShowRecipeViewModel(post: post, curUser: curUser))
        self.curCheck = curCheck
    }
    @State private var showEditSeet = false

    var body: some View {
        VStack {
            if curCheck {
                RecipeHeaderView(postTitle: "Test", showEditSheet: $showEditSeet, recipeModel: recipeModel)
            }
            ScrollView {
                VStack{
                    //画像配置
                    if recipeModel.post.imageUrl != "" {
                        KFImage(URL(string: recipeModel.post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .clipped()
                    } else {
                        //ここはあとからnoImageの画像に変える
                        Image(.noimage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .clipped()
                        //画像に白いフィルターを付ける
                    }
                    HStack{
                        Text(recipeModel.post.title)
                        Spacer()
                        Button("お気に入り"){
                            print("お気に入り登録！")
                            Task {
                                try await recipeModel.updateUserData(postId: recipeModel.post.id)
                                try await viewModel.fetchCurUser()
                            }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 10)
                    
                    Divider()
                    
                    
                    HStack{
                        if let postUser = recipeModel.post.user {
                            CircularProfileImageView(user: postUser, size: .xSmall)
                            
                        } else {
                            CircularProfileImageView(user: User.MOCK_USERS[0], size: .xSmall)
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal, 10)
                   
                    
                    Text(recipeModel.post.introduction)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                    
                    Divider()
                    
                    VStack{
                        Text("材料")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(recipeModel.post.ingredientsPeople)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(0..<recipeModel.post.ingredientsValues.count, id: \.self) { index in
                            HStack{
                                Text(recipeModel.post.ingredientsValues[index])
                                Spacer()
                                Text(recipeModel.post.ingredientsAmount[index])
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            Divider()
                        }
                    }
                    .padding(10)
                    
                    VStack {
                        Text("作り方")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ForEach(0..<recipeModel.post.methodValues.count, id: \.self) { index in
                            VStack{
                                HStack{
                                    Text("\(index + 1)")
                                        .frame(width: 20, height: 20)
                                    Text(recipeModel.post.methodValues[index])
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                Divider()
                            }
                            
                        }
                    }
                    .padding(10)
                    
                    VStack{
                        Text("公開日:\(formatDate(recipeModel.post.timestamp.dateValue()))")
                    }
                }
            }
            .toolbar(curCheck ? .hidden : .visible, for: .navigationBar)
            //.navigationBarHidden(curCheck ? true : false)
            
        }
        .fullScreenCover(isPresented: $showEditSeet) {
            RecipeEditView(recipeModel: recipeModel)
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月d日"
        return formatter.string(from: date)
    }
}


#Preview {
    showRecipeView(post: Post.MOCK_POSTS[0], curUser: User.MOCK_USERS[0])
}
