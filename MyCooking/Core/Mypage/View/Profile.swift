//
//  Profile.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    
    var body: some View {
        
        
        ScrollView {
            
            ProfileHeaderView(user: user)
            
            //grid
            PostGridView(user: user)
        }
        .navigationTitle("MyPage")
        .navigationBarTitleDisplayMode(.inline)
        
        
        
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS[0])
}
