//
//  ItemScrollView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/08.
//

import SwiftUI
import Kingfisher

struct ItemScrollView: View {
    
    let category: String
    let posts: [Post]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 5) - 1
    private let imageHeight: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        
        //検索したcategoryを表示する
        let filterPosts = posts.filter { post in
            return post.category.contains(category)
        }
        
        if filterPosts.isEmpty{
            
        } else {
            VStack {
                Text(category)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(filterPosts){ post in
                            if let user = post.user {
                                NavigationLink(destination: showRecipeView(post: post, user: user)){
                                    VStack{
                                        KFImage(URL(string: post.imageUrl))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: imageDimension, height: imageDimension)
                                            .clipped()
                                        
                                        Text(post.introduction)
                                            .font(.caption)
                                        Spacer()
                                    }
                                    .frame(width: imageDimension, height: imageHeight)
                                }
                                
                            }
                            
                            
                            
                        }
                    }
                    
                    
                }//scroll
            }
        }
        
        
        
    }
}
