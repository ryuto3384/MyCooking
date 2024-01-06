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
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: PostGridViewModel(user: user))
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
                showRecipeView(user: viewModel.user, post: post)
            })
            
    }
}

#Preview {
    PostGridView(user: User.MOCK_USERS[0])
}
