//
//  PostGridViewModel.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

class PostGridViewModel: ObservableObject {
    private let user: User
    @Published var posts = [Post]()
    
    init(user: User, posts: [Post] = [Post]()) {
        self.user = user
        self.posts = posts
    }
    
    init(user: User) {
        self.user = user
        
        Task { try await fetchUserPosts() }
    }
    
    @MainActor
    func fetchUserPosts() async throws{
        self.posts = try await PostService.fetchUserPosts(uid: user.id)
        
        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
    }
}
