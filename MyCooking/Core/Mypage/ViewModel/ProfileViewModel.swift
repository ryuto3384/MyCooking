//
//  ProfileViewModel.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/21.
//

import SwiftUI


class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var posts = [Post]()
    init(user: User) {
        self.user = user
        Task {
            try await fetchUsers()
            try await fetchUserPosts()
        }
    }
    
    @MainActor
    func fetchUsers() async throws {
        self.user = try await UserService.fetchUser(withUid: user.id)
    }
    
    @MainActor
    func fetchUserPosts() async throws{

        self.posts = try await PostService.fetchUserPosts(uid: self.user.id)
        
        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
    }
}

