//
//  Profile.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

struct ProfileView: View {
    let user: User

    @EnvironmentObject var viewModel: MainTabViewModel
    
    var body: some View {

        ScrollView {
            
            ProfileHeaderView(user: user)
            
            Divider()
            
            //grid
            PostGridView(user: user, posts: viewModel.allPosts, currentCheck: false)
        }
        .navigationTitle("MyPage")
        .navigationBarTitleDisplayMode(.inline)
        
        
        
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS[0])
}
