//
//  PostGridView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    @StateObject var viewModel: PostGridViewModel
    
    init(user: User, posts: [Post]) {
        self._viewModel = StateObject(wrappedValue: PostGridViewModel(user: user, posts: posts))
    }
    
    private let gridItem : [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        if !viewModel.fetchTime {
            if !viewModel.posts.isEmpty {
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
            }else {
                NotingView(text: "投稿していません")
            }
        }else {
            ProgressView()
        }
    }
}

#Preview {
    PostGridView(user: User.MOCK_USERS[0], posts: Post.MOCK_POSTS)
}
