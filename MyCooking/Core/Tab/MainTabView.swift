//
//  MainTabView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

struct MainTabView: View {
    
    let user: User
    
    @State private var selectedIndex = 2
    
    var body: some View {
        TabView(selection: $selectedIndex){
            ItemView()
                .onAppear{
                    selectedIndex = 0
                }
                .tabItem{
                    Image(systemName: "house")
                }
                .tag(0)
            TicktokView()
                .onAppear{
                    selectedIndex = 1
                }
                .tabItem{
                    Image(systemName: "magnifyingglass")
                }
                .tag(1)
            HomeView()
                .onAppear{
                    selectedIndex = 2
                }
                .tabItem{
                    Image(systemName: "plus.square")
                }
                .tag(2)
            UploadView(tabIndex: $selectedIndex)
                .onAppear{
                    selectedIndex = 3
                }
                .tabItem{
                    Image(systemName: "heart")
                }
                .tag(3)
            CurrentUserProfileView(user: user )
                .onAppear{
                    selectedIndex = 4
                }
                .tabItem{
                    Image(systemName: "person")
                }
                .tag(4)
        }
        //これで選択したものに色を付けられる

        .accentColor(.black)
    }
}

#Preview {
    MainTabView(user: User.MOCK_USERS[0])
}
