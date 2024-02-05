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
    
    init(post: Post, _ curCheck: Bool = false) {
        self._recipeModel = StateObject(wrappedValue: ShowRecipeViewModel(post: post))
        self.curCheck = curCheck
    }
    @State private var showEditSeet = false
    
    @Namespace private var animation
    var body: some View {
        ZStack {
            VStack {
                if curCheck {
                    RecipeHeaderView(postTitle: "レシピ", showEditSheet: $showEditSeet, recipeModel: recipeModel)
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
                            Button{
                                Task {
                                    try await viewModel.updateUserData(postId: recipeModel.post.id)
                                    try await viewModel.fetchCurUser()
                                    
                                }
                            } label: {
                                Image(systemName: viewModel.checkFavorite(recipeModel.post.id) ? "bookmark.fill" : "bookmark")
                                    .font(.title)
                                    .padding(.horizontal, 3)
                            }
                        }
                        .padding(.top, 20)
                        .padding(.horizontal, 10)
                        
                        Divider()
                        
                        
                        HStack{
                            if let postUser = recipeModel.post.user {
                                CircularProfileImageView(user: postUser, size: .xSmall)
                                //let _ = print("DEBUG:成功")
                            } else {
                                //let _ = print("DEBUG:失敗")
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
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(recipeModel.post.category, id: \.self) { tag in
                                        TagView(tag, .pink, "checkmark")
                                            .matchedGeometryEffect(id: tag, in: animation)
                                    }
                                    
                                }
                            }
                            .padding(.horizontal, 3)
                        }
                        
                        VStack{
                            Text("公開日:\(formatDate(recipeModel.post.timestamp.dateValue()))")
                        }
                    }
                }
                .toolbar(curCheck ? .hidden : .visible, for: .navigationBar)
                //.navigationBarHidden(curCheck ? true : false)
                
            }
            if viewModel.showProgressFlag {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color.black.opacity(0.2))
            }
        }
        .fullScreenCover(isPresented: $showEditSeet) {
            RecipeEditView(recipeModel: recipeModel)
        }
        .navigationTitle("レシピ")
        
        
        
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月d日"
        return formatter.string(from: date)
    }
    
    @ViewBuilder
    func TagView(_ tag: String, _ color: Color, _ icon: String) -> some View {
        HStack(spacing: 10) {
            Text(tag)
                .font(.callout)
                .fontWeight(.semibold)
            
            Image(systemName: icon)
        }
        .frame(height: 35)
        .foregroundStyle(.white)
        .padding(.horizontal, 15)
        .background{
            Capsule()
                .fill(color.gradient)
        }
    }
}


#Preview {
    showRecipeView(post: Post.MOCK_POSTS[0])
}
