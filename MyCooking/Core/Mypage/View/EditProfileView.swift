//
//  Edit.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: MainTabViewModel
    
    var body: some View {
        VStack {
            //toolbar
            VStack {
                HStack {
                    Button("キャンセル") {
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Text("プロフィール編集")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button {
                        Task {
                            try await viewModel.updateUserData()
                            dismiss()
                        }
                        
                    } label: {
                        Text("完了")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
                .padding(.top, 15)
                .padding(.horizontal)
                
                Divider()
            }
            
            //edit pic
            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(.white)
                            .background(.gray)
                            .clipShape(Circle())
                    } else {
                        CircularProfileImageView(user: viewModel.curUser, size: .large)
                    }
                    
                    Text("写真選択")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Divider()
                }
            }
            .padding(.vertical, 8)
            
            //edit profile inro
            VStack {
                EditProfileRowView(title: "名前", placeholder: "太郎", text: $viewModel.fullname)
                
                EditProfileRowView(title: "ひとこと", placeholder: "よろしく！", text: $viewModel.bio)
                
                Spacer()
            }
        }
    }
}

struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            
            VStack {
                TextField(placeholder, text: $text)
                
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

#Preview {
    EditProfileView()
}
