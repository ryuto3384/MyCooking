//
//  PostGridViewModel.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

class PostGridViewModel: ObservableObject {
    @Published var user: User
    @Published var posts: [Post]
    @Published var fetchTime: Bool = false
    
    init(user: User, posts: [Post]) {
        self.user = user
        self.posts = posts
        Task { try await fetchUserPosts() }
    }
     
    @MainActor
    func fetchUserPosts() async throws{
        //print("呼び出された")
        fetchTime = true
        
        self.user = try await UserService.fetchUser(withUid: user.id)
        
        self.posts = try await PostService.fetchUserPosts(uid: self.user.id)
        
        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
        
        fetchTime = false
    }
}
