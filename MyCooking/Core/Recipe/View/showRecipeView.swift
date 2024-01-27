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
    
    @StateObject var viewModel: ShowRecipeViewModel
    
    let curCheck: Bool
    
    init(post: Post, user: User, curCheck: Bool) {
        self._viewModel = StateObject(wrappedValue: ShowRecipeViewModel(post: post, user: user))
        self.curCheck = curCheck
    }
    @State private var showEditSeet = false

    var body: some View {
        VStack {
            if curCheck {
                RecipeHeaderView(postTitle: "Test", showEditSheet: $showEditSeet)
            }
            ScrollView {
                VStack{
                    //画像配置
                    if viewModel.post.imageUrl != "" {
                        KFImage(URL(string: viewModel.post.imageUrl))
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
                        Text(viewModel.post.title)
                        Spacer()
                        Button("お気に入り"){
                            print("お気に入り登録！")
                            Task { try await viewModel.updateUserData(postId: viewModel.post.id) }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 10)
                    
                    Divider()
                    
                    HStack{
                        CircularProfileImageView(user: viewModel.user, size: .xSmall)
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    
                    Text(viewModel.post.introduction)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                    
                    Divider()
                    
                    VStack{
                        Text("材料")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(viewModel.post.ingredientsPeople)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(0..<viewModel.post.ingredientsValues.count, id: \.self) { index in
                            HStack{
                                Text(viewModel.post.ingredientsValues[index])
                                Spacer()
                                Text(viewModel.post.ingredientsAmount[index])
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
                        
                        ForEach(0..<viewModel.post.methodValues.count, id: \.self) { index in
                            VStack{
                                HStack{
                                    Text("\(index + 1)")
                                        .frame(width: 20, height: 20)
                                    Text(viewModel.post.methodValues[index])
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                Divider()
                            }
                            
                        }
                    }
                    .padding(10)
                    
                    VStack{
                        Text("公開日:\(formatDate(viewModel.post.timestamp.dateValue()))")
                    }
                }
            }
            .toolbar(curCheck ? .hidden : .visible, for: .navigationBar)
            //.navigationBarHidden(curCheck ? true : false)
            
        }
        .fullScreenCover(isPresented: $showEditSeet) {
            RecipeEditView(viewModel: viewModel)
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月d日"
        return formatter.string(from: date)
    }
}


#Preview {
    showRecipeView(post: Post.MOCK_POSTS[0], user: User.MOCK_USERS[0],curCheck: true)
}
