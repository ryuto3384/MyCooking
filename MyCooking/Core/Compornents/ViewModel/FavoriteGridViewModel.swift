//
//  FavoriteGridViewModel.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/18.
//

import SwiftUI

class FavoriteGridViewModel: ObservableObject {
    @Published var user: User
    @Published var posts = [Post]()
    @Published var fetchTime: Bool = false
    
    init(user: User, posts: [Post] = [Post]()) {
        self.user = user
        self.posts = posts
        Task {
            try await fetchUserPosts()
        }
    }
    
    @MainActor
    func fetchUserPosts() async throws{
        
        fetchTime = true
        
        self.user = try await UserService.fetchUser(withUid: user.id)
        
        self.posts = try await PostService.fetchUserFavoritePosts(id: self.user.favoriteList)
        

        fetchTime = false
        
    }
}
