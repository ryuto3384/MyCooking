//
//  ProfileHeaderView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    @State private var showEdhitProfile = false
    
    var body: some View {
        VStack(spacing: 10) {
            HStack{
                CircularProfileImageView(user: user, size: .large)
                
                Spacer()
                
                HStack(spacing: 8){
                    UserStatView(value: 0, title: "投稿")
                    UserStatView(value: user.follow, title: "フォロワー")
                    UserStatView(value: user.followers, title: "フォロー中")
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
                    //フォローする関数
                }
            } label: {
                Text(user.isCurrentUser ? "プロフィールを編集" : "フォロー")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .background(user.isCurrentUser ? .white : Color(.systemBlue))
                    .foregroundStyle(user.isCurrentUser ? .black : .white)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6).stroke(user.isCurrentUser ? .gray : .clear, lineWidth: 1)
                    )
            }
            
            //区切り線
            Divider()
        }
        .fullScreenCover(isPresented: $showEdhitProfile) {
            EditProfileView(user: user)
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USERS[0])
}
