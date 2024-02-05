//
//  SwiftUIView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

enum GridOption: String, CaseIterable {
    case myPost = "投稿"
    case favorite = "お気に入り"
}

struct CurrentUserProfileView: View {

    @EnvironmentObject var viewModel: MainTabViewModel

    @State private var gridOption = GridOption.myPost

    var body: some View {
        NavigationStack {
            ScrollView {
                CurrentUserProfileHeaderView()
                
                Picker("検索オプション", selection: $gridOption){
                    ForEach(GridOption.allCases, id: \.self) { option in
                        Text(option.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 1)
                
                if gridOption == GridOption.myPost {
                    PostGridView(user: viewModel.curUser, currentCheck: true)
                        
                } else {
                    FavoriteGridView(user: viewModel.curUser, currentCheck: false)
                }
                
            }
            .navigationTitle("プロフィール")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        AuthService.shared.signout()
                    }, label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
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
    CurrentUserProfileView()
}
