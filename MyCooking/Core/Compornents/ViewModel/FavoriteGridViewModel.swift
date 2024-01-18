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
    
    init(user: User, posts: [Post] = [Post]()) {
        self.user = user
        self.posts = posts
    }
    
    init(user: User) {
        self.user = user
        
        Task {
            try await fetchUserPosts()
        }
    }
    
    @MainActor
    func fetchUserPosts() async throws{
        
        self.user = try await UserService.fetchUser(withUid: user.id)
        
        self.posts = try await PostService.fetchUserFavoritePosts(id: self.user.favoriteList)
        
        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
        
    }
}
