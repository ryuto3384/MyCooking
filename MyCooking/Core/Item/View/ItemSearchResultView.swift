//
//  ItemSearchResultView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/08.
//

import SwiftUI
import Kingfisher

struct ItemSearchResultView: View {
    
    let post: Post
    
    var body: some View {
        
        HStack{
            VStack{
                Text(post.title)
                HStack{
                    ForEach(post.ingredientsValues, id: \.self) { value in
                        Text(value)
                    }
                }
                HStack{
                    if let user = post.user {
                        CircularProfileImageView(user: user, size: .xSmall)
                        Text(user.username)
                    }
                }
            }
            KFImage(URL(string: post.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 130,height: 130)
                .clipped()
        }
        
    }
}


