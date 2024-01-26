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
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 4) - 1
    private let imageHeight: CGFloat = (UIScreen.main.bounds.width / 2.5) - 1
    
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
                    .foregroundStyle(Color("TextColor1"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .shadow(color: .black.opacity(0.75), radius: 3, x: 2, y: 2)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 10) {
                        ForEach(filterPosts){ post in
                            if let user = post.user {
                                NavigationLink(destination: showRecipeView(post: post, user: user)){
                                    VStack{
                                        KFImage(URL(string: post.imageUrl))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: imageDimension, height: imageDimension)
                                            .clipped()
                                            .shadow(color: .black.opacity(0.75), radius: 3, x: 2, y: 2)
                                            
                                        
                                        
                                        Text(post.introduction)
                                            .font(.caption)
                                            .foregroundStyle(Color("TextColor1"))
                                            .multilineTextAlignment(.leading)
                                            .shadow(color: .black.opacity(0.75), radius: 3, x: 1, y: 1)
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

#Preview {
    ItemView(viewModel: MainTabViewModel())
}

