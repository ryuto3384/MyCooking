//
//  Profile.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

struct ProfileView: View {

    @StateObject var viewModel: ProfileViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
    }
    
    var body: some View {
        
        
        
        ScrollView {
            
            ProfileHeaderView(user: viewModel.user)
            
            Divider()
            
            //grid
            PostGridView(user: viewModel.user, posts: viewModel.posts)
        }
        .navigationTitle("MyPage")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            
        }
        
        
        
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS[0])
}
