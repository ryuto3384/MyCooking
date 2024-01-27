//
//  ResultTextListView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/25.
//

import SwiftUI

struct ResultTextListView: View {
    
    let posts: [Post]
    let searchText: String
    
    private let widthSize: CGFloat = UIScreen.main.bounds.width - 1
    
    var body: some View {
        List {
            
            
            let filterPosts = posts.filter { post in
                let searchTextLowercased = searchText.lowercased()
                return post.category.contains(searchTextLowercased) || post.title.contains(searchTextLowercased)
            }
            
            
            ForEach(filterPosts) { post in
                NavigationLink(destination: showRecipeView(post: post, user: post.user ?? User.MOCK_USERS[0], curCheck: false)){
                    ResultCellView(post: post)
                        .frame(width: widthSize, height: 130)
                }
            }
            
            
            
        }
        .navigationBarHidden(true)
        .listStyle(.inset)
    }
}

#Preview {
    ResultTextListView(posts: Post.MOCK_POSTS, searchText: "a")
}

