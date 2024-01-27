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
    
    let currentCheck: Bool
    
    init(user: User, currentCheck: Bool) {
        self._viewModel = StateObject(wrappedValue: FavoriteGridViewModel(user: user))
        self.currentCheck = currentCheck
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
                    showRecipeView(post: post, user: viewModel.user, curCheck: currentCheck)
                })
            } else {
                NotingView(text: "お気に入り登録していません")
            }
        } else {
            ProgressView()
        }
    }//someview
}

#Preview {
    FavoriteGridView(user: User.MOCK_USERS[0], currentCheck: true)
}
