//
//  FavoriteGridView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/18.
//

import SwiftUI
import Kingfisher

struct FavoriteGridView: View {
    @EnvironmentObject var viewModel: MainTabViewModel
    
    let user: User
    
    let currentCheck: Bool
    
    @State private var posts: [Post] = []
    
    private let gridItem : [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        VStack{
            if !viewModel.showProgressFlag {
                if !posts.isEmpty {
                    LazyVGrid(columns: gridItem, spacing: 1){
                        ForEach(posts) { post in
                            NavigationLink(destination: showRecipeView(post: post)){
                                KFImage(URL(string: post.imageUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: imageDimension, height: imageDimension)
                                    .clipped()
                                
                            }
                        }
                    }
                } else {
                    NotingView(text: "お気に入り登録していません")
                }
            } else {
                ProgressView()
            }
        }.onAppear{
            Task {
                do {
                    viewModel.showProgressFlag = true
                    let userFavoritePost = try await viewModel.fetchUserFavorite(user.favoriteList)
                    posts = userFavoritePost
                    viewModel.showProgressFlag = false
                } catch {
                    print(error)
                }
            }
        }
    }//someview
}

#Preview {
    FavoriteGridView(user: User.MOCK_USERS[0], currentCheck: true)
}
