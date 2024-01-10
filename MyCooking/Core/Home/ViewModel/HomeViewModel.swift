//
//  HomeViewModel.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/09.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    
    @Published var displaying_posts: [Post]?
    
    @Published var favorite: [Post]?
    
    init(){
        Task { try await fetchPosts() }
        
        //        print("-----------------------------------------------")
        //        print("DEBUG:\(posts.count)")
        //        print("-----------------------------------------------")
        
    }
    
    func getIndex(food: Post) -> Int {
        let index = displaying_posts?.firstIndex(where: { currentFood in
            return food.id == currentFood.id
        }) ?? 0
        
        return index
    }
    
    func addItem(food: Post) {
        print(food)
        if var favorite = self.favorite {
            favorite.append(food)
            self.favorite = favorite
        } else {
            self.favorite = [food]
        }
        print("-----------------------------------------------")
        print(self.favorite?.count ?? 0)
        print("-----------------------------------------------")
    }
    
    @MainActor
    func fetchPosts() async throws {
        self.posts = try await PostService.fetchFeedPosts()
        self.displaying_posts = self.posts.shuffled()
    }
}
