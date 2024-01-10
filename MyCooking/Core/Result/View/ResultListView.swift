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
    
    var body: some View {
        List {
            if category == "" {
                ForEach(posts) { post in
                    NavigationLink(destination: showRecipeView(user: post.user ?? User.MOCK_USERS[0], post: post)){
                        ResultCellView(post: post)
                    }
                }
            } else {
                ForEach(posts.filter{ $0.category == category}){ post in
                    NavigationLink(destination: showRecipeView(user: post.user ?? User.MOCK_USERS[0], post: post)){
                        ResultCellView(post: post)
                    }
                }
            }
            
            
        }
        .listStyle(.inset)
    }
}
