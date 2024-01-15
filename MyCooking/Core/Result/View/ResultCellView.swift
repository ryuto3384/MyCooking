//
//  ResultCellView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/10.
//

import SwiftUI
import Kingfisher

struct ResultCellView: View {
    let post: Post
    
    var body: some View {
        
        HStack{
            VStack{
                HStack{
                    Text(post.title)
                        .font(.title3)
                    Spacer()
                }
                
                HStack{
                    ForEach(post.ingredientsValues, id: \.self) { value in
                        Text(value)
                            .font(.caption)
                    }
                    Spacer()
                }
                HStack{
                    if let user = post.user {
                        CircularProfileImageView(user: user, size: .xSmall)
                        Text(user.username)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal)
            Spacer()
            KFImage(URL(string: post.imageUrl))
            //Image(post.imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: 130,height: 130)
                .clipped()
        }
        
    }
}

#Preview {
    ResultListView(posts: Post.MOCK_POSTS, category: "")
}
