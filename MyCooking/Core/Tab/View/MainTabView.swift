//
//  MainTabView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedIndex = 2
    
    @StateObject private var viewModel: MainTabViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: MainTabViewModel(user: user))
    }
    
    var body: some View {
        TabView(selection: $selectedIndex){
            
            ItemView()
                .onAppear{
                    selectedIndex = 0
                    print("----------------------------")
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
            UploadView(tabIndex: $selectedIndex)
                .onAppear{
                    selectedIndex = 3
                }
                .tabItem{
                    Image(systemName: "square.and.pencil")
                        .padding(.top, 20)
                }
                .tag(3)
            CurrentUserProfileView()
                .onAppear{
                    selectedIndex = 4
                }
                .tabItem{
                    Image(systemName: "person")
                        .padding(.top, 20)
                }
                .tag(4)
        }
        .environmentObject(viewModel)
        .toolbarBackground(.visible, for: .tabBar).toolbarBackground(Color.indigo, for: .tabBar)
        
        
        .disabled(viewModel.showProgressFlag)
        //これで選択したものに色を付けられる
        .accentColor(.black)
    }
}





#Preview {
    MainTabView(user: User.MOCK_USERS[0])
}
