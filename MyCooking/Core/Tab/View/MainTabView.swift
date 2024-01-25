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
            Group {
                ItemView()
                    .onAppear{
                        selectedIndex = 0
                    }
                    .tabItem{
                        Image(systemName: "list.bullet.clipboard")
                            .padding(.top, 20)
                    }
                    .tag(0)
                SearchView()
                    .onAppear{
                        selectedIndex = 1
                    }
                    .tabItem{
                        Image(systemName: "magnifyingglass")
                            .padding(.top, 20)
                    }
                    .tag(1)
                HomeView()
                    .onAppear{
                        selectedIndex = 2
                    }
                    .tabItem{
                        Image(systemName: "fork.knife.circle")
                            .padding(.top, 20)
                    }
                    .tag(2)
                UploadView(tabIndex: $selectedIndex, user: user)
                    .onAppear{
                        selectedIndex = 3
                    }
                    .tabItem{
                        Image(systemName: "square.and.pencil")
                            .padding(.top, 20)
                    }
                    .tag(3)
                CurrentUserProfileView(user: user )
                    .onAppear{
                        selectedIndex = 4
                    }
                    .tabItem{
                        Image(systemName: "person")
                            .padding(.top, 20)
                    }
                    .tag(4)
            }
        }
        //これで選択したものに色を付けられる
        .accentColor(.black)
    }
}



#Preview {
    MainTabView(user: User.MOCK_USERS[0])
}
