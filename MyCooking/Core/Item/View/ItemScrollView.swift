//
//  ItemScrollView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/08.
//

import SwiftUI

struct ItemScrollView: View {
    
    let category = "朝食"
    let intro = "簡単で美味しい"
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 5) - 1
    
    var body: some View {
        
        //検索したcategoryを表示する
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<5){_ in
                    
                    NavigationLink(destination: showRecipeView(user: User.MOCK_USERS[0], post: Post.MOCK_POSTS[0])){
                        VStack{
                            Image(.syumagi1)
                                .resizable()
                                .scaledToFill()
                                .frame(width: imageDimension, height: imageDimension)
                                .clipped()
                            
                            Text(intro)
                        }
                    }
                    
                    
                    
                }
            }
            
        }
        
    }
}

#Preview {
    ItemScrollView()
}
