//
//  FavoriteGridView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/18.
//

import SwiftUI
import Kingfisher

struct FavoriteGridView: View {
    @StateObject var viewModel: FavoriteGridViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: FavoriteGridViewModel(user: user))
    }
    
    private let gridItem : [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
            LazyVGrid(columns: gridItem, spacing: 1){
                ForEach(viewModel.posts) { post in
                    NavigationLink(value: post) {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageDimension, height: imageDimension)
                            .clipped()
                        
                    }
                }
            }.navigationDestination(for: Post.self, destination: { post in
                showRecipeView(post: post, user: viewModel.user)
            })
            .onAppear{
                Task { try await viewModel.fetchUserPosts() }
            }
            
    }
}

#Preview {
    FavoriteGridView(user: User.MOCK_USERS[0])
}
