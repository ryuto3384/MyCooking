//
//  ProfileHeaderView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

struct ProfileHeaderView: View {
    @State var user: User
    @EnvironmentObject var viewModel: MainTabViewModel
    
    @State private var showEdhitProfile = false
    
    var body: some View {
        VStack(spacing: 10) {
            HStack{
                CircularProfileImageView(user: user, size: .large)
                
                Spacer()
                
                HStack(spacing: 8){
                    UserStatView(value: user.postCount, title: "投稿")
                    UserStatView(value: user.followers.count, title: "フォロワー")
                    UserStatView(value: user.follow.count, title: "フォロー中")
                }
            }
            .padding(.horizontal)
            
            //アカウント名
            VStack(alignment: .leading, spacing: 4){
                if let fullname = user.fullname {
                    Text(fullname)
                        .font(.footnote)
                        .fontWeight(.semibold)
                } else {
                    Text(user.username)
                }
                
                
                if let bio = user.bio {
                    Text(bio)
                        .font(.footnote)
                }
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Button {
                if user.isCurrentUser {
                    //editの編集画面へ
                    showEdhitProfile.toggle()
                } else {
                    if viewModel.checkFollow(user.id) {
                        Task {
                            try await viewModel.deleteFollow(user: user)
                            self.user = try await viewModel.fetchSelectedUser(selectUserId: user.id)
                            try await viewModel.fetchAllUsers()
                        }
                    } else {
                        //フォローする関数
                        Task {
                            try await viewModel.registFollow(user: user)
                            self.user = try await viewModel.fetchSelectedUser(selectUserId: user.id)
                            try await viewModel.fetchAllUsers()
                        }
                        
                    }
                    
                    
                }
            } label: {
                
                Text(user.isCurrentUser ? "プロフィールを編集" : viewModel.checkFollow(user.id) ? "フォロー中" : "フォロー")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .background(user.isCurrentUser ? .white : viewModel.checkFollow(user.id) ? Color(.systemGray5) : Color(.systemBlue))
                    .foregroundStyle(user.isCurrentUser ? .black : viewModel.checkFollow(user.id) ? .black : .white)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6).stroke(user.isCurrentUser ? .gray : .clear, lineWidth: 1)
                    )
                
            }
            
            //区切り線
            //Divider()
        }
        .fullScreenCover(isPresented: $showEdhitProfile) {
            EditProfileView()
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USERS[0])
}
