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
            
            ProfileHeaderView()
            
            Divider()
            
            //grid
            PostGridView(user: viewModel.curUser, posts: viewModel.allPosts, currentCheck: false)
        }
        .navigationTitle("MyPage")
        .navigationBarTitleDisplayMode(.inline)
        
        
        
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS[0])
}
