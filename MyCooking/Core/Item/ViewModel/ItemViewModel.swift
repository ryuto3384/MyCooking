//
//  ItemViewModel.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/08.
//

import SwiftUI

class ItemViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    @Published var fetchTime: Bool = false
    
    init(){
        Task { try await fetchPosts() }
    }
    
    @MainActor
    func fetchPosts() async throws {
        fetchTime = true
        self.posts = try await PostService.fetchFeedPosts(cate: "")
        fetchTime = false
    }
}
