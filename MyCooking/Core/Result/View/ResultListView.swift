//
//  ResultListView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/10.
//

import SwiftUI

struct ResultListView: View {
    
    @EnvironmentObject var viewModel: MainTabViewModel
    let category: String
    
    private let widthSize: CGFloat = UIScreen.main.bounds.width - 1
    
    var body: some View {
        List {
            if category == "" {
                ForEach(viewModel.allPosts) { post in
                    NavigationLink(destination: showRecipeView(post: post)){
                        ResultCellView(post: post)
                            .frame(width: widthSize, height: 130)
                    }
                }
            } else {
                
                let filterPosts = viewModel.allPosts.filter { post in
                    return post.category.contains(category)
                }
                
                ForEach(filterPosts) { post in
                    NavigationLink(destination: showRecipeView(post: post)){
                        ResultCellView(post: post)
                            .frame(width: widthSize, height: 130)
                    }
                }
            }
            
            
        }
        .toolbar(.hidden, for: .navigationBar)
        //.navigationBarHidden(true)
        .listStyle(.inset)
    }
}

#Preview {
    ResultListView(category: "")
}
