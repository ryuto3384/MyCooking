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

    @StateObject var viewModel: ProfileViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
    }
    
    @State private var gridOption = GridOption.myPost

    var body: some View {
        NavigationStack {
            ScrollView {
                ProfileHeaderView(user: viewModel.user)
                
                Picker("検索オプション", selection: $gridOption){
                    ForEach(GridOption.allCases, id: \.self) { option in
                        Text(option.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 1)
                
                if gridOption == GridOption.myPost {
                    PostGridView(user: viewModel.user, posts: viewModel.posts, currentCheck: true)
                        
                } else {
                    FavoriteGridView(user: viewModel.user, currentCheck: false)
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

struct NotingView: View {
    
    let text: String
    
    var body: some View{
        VStack{
            Spacer(minLength: 200)
            Text(text)
                .font(.title2)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    CurrentUserProfileView(user: User.MOCK_USERS[0])
}
