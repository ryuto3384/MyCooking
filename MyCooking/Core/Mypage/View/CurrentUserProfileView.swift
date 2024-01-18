//
//  SwiftUIView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

enum GridOption: String, CaseIterable {
    case myPost = "myPost"
    case favorite = "favofite"
}

struct CurrentUserProfileView: View {
    
    let user: User
    
    @State private var gridOption = GridOption.myPost

    var body: some View {
        NavigationStack {
            ScrollView {
                ProfileHeaderView(user: user)
                
                Picker("検索オプション", selection: $gridOption){
                    ForEach(GridOption.allCases, id: \.self) { option in
                        Text(option.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 1)
                
                if gridOption == GridOption.myPost {
                    //grid
                    PostGridView(user: user)
                } else {
                    FavoriteGridView(user: user)
                }
                
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        AuthService.shared.signout()
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    })
                }
            }
        }
    }
    
}

#Preview {
    CurrentUserProfileView(user: User.MOCK_USERS[0])
}
