//
//  showRecipeView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/06.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct showRecipeView: View {
    
    @StateObject var viewModel = ShowRecipeViewModel()
    
    let user: User
    let post: Post
    
    var body: some View {
        VStack {
            ScrollView {
                VStack{
                    //画像配置
                    if post.imageUrl != "" {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .clipped()
                    } else {
                        //ここはあとからnoImageの画像に変える
                        Image(.syumagi1)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .clipped()
                        //画像に白いフィルターを付ける
                    }
                    HStack{
                        Text(post.title)
                        Spacer()
                        Button("お気に入り"){
                            print("お気に入り登録！")
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 10)
                    
                    Divider()
                    
                    HStack{
                        CircularProfileImageView(user: user, size: .xSmall)
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    
                    Text(post.introduction)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                    
                    Divider()
                    
                    VStack{
                        Text("材料")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(post.ingredientsPeople)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(0..<post.ingredientsValues.count, id: \.self) { index in
                            HStack{
                                Text(post.ingredientsValues[index])
                                Spacer()
                                Text(post.ingredientsAmount[index])
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(10)
                    
                    VStack {
                        Text("作り方")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ForEach(0..<post.methodValues.count, id: \.self) { index in
                            VStack{
                                HStack{
                                    Text("\(index + 1)")
                                        .frame(width: 20, height: 20)
                                    Text(post.methodValues[index])
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                Divider()
                            }
                            
                        }
                    }
                    .padding(10)
                    
                    VStack{
                        Text("公開日:\(post.timestamp)")
                    }
                }
            }
            
        }
    }
}


#Preview {
    showRecipeView(user: User.MOCK_USERS[0], post: Post.MOCK_POSTS[0])
}
