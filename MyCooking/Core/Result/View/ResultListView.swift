//
//  ResultListView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/10.
//

import SwiftUI

struct ResultListView: View {
    
    let posts: [Post]
    let category: String
    
    private let widthSize: CGFloat = UIScreen.main.bounds.width - 1
    
    var body: some View {
        List {
            if category == "" {
                ForEach(posts) { post in
                    NavigationLink(destination: showRecipeView(post: post, user: post.user ?? User.MOCK_USERS[0])){
                        ResultCellView(post: post)
                            .frame(width: widthSize, height: 130)
                    }
                }
            } else {
                
                let filterPosts = posts.filter { post in
                    return post.category.contains(category)
                }
                
                ForEach(filterPosts) { post in
                    NavigationLink(destination: showRecipeView(post: post, user: post.user ?? User.MOCK_USERS[0])){
                        ResultCellView(post: post)
                            .frame(width: widthSize, height: 130)
                    }
                }
            }
            
            
        }
        .navigationBarHidden(true)
        .listStyle(.inset)
    }
}

#Preview {
    ResultListView(posts: Post.MOCK_POSTS, category: "")
}
