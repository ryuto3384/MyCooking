//
//  ProfileHeaderView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

struct ProfileHeaderView: View {
    @StateObject var viewModel: ProfileHeaderViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: ProfileHeaderViewModel(user: user))
    }
    
    @State private var showEdhitProfile = false
    
    var body: some View {
        VStack(spacing: 10) {
            HStack{
                CircularProfileImageView(user: viewModel.user, size: .large)
                
                Spacer()
                
                HStack(spacing: 8){
                    UserStatView(value: viewModel.user.postCount, title: "投稿")
                    UserStatView(value: viewModel.user.followers.count, title: "フォロワー")
                    UserStatView(value: viewModel.user.follow.count, title: "フォロー中")
                }
            }
            .padding(.horizontal)
            
            //アカウント名
            VStack(alignment: .leading, spacing: 4){
                if let fullname = viewModel.user.fullname {
                    Text(fullname)
                        .font(.footnote)
                        .fontWeight(.semibold)
                } else {
                    Text(viewModel.user.username)
                }
                
                
                if let bio = viewModel.user.bio {
                    Text(bio)
                        .font(.footnote)
                }
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Button {
                if viewModel.user.isCurrentUser {
                    //editの編集画面へ
                    showEdhitProfile.toggle()
                } else {
                    if viewModel.checkFollow() {
                        Task { try await viewModel.deleteFollow()}
                    } else {
                        //フォローする関数
                        Task { try await viewModel.registFollow() }
                        
                    }
                    
                    
                }
            } label: {
                
                Text(viewModel.user.isCurrentUser ? "プロフィールを編集" : viewModel.checkFollow() ? "フォロー中" : "フォロー")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .background(viewModel.user.isCurrentUser ? .white : viewModel.checkFollow() ? Color(.systemGray5) : Color(.systemBlue))
                    .foregroundStyle(viewModel.user.isCurrentUser ? .black : viewModel.checkFollow() ? .black : .white)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6).stroke(viewModel.user.isCurrentUser ? .gray : .clear, lineWidth: 1)
                    )
                
            }
            
            //区切り線
            //Divider()
        }
        .fullScreenCover(isPresented: $showEdhitProfile) {
            EditProfileView(user: viewModel.user)
        }
        .onAppear{
            Task { try await viewModel.loadUser() }
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USERS[0])
}
