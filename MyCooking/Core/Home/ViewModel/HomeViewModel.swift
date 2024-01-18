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
    
    @Published var showProgressFlag: Bool = false
    
    @Published var selectCate = ""
    
    init(){
        Task { try await fetchPosts() }
        
        //        print("-----------------------------------------------")
        //        print("DEBUG:\(posts.count)")
        //        print("-----------------------------------------------")
        
    }
    
    func getIndex(food: Post) -> Int {
        let index = displaying_posts?.lastIndex(where: { currentFood in
            return food.id == currentFood.id
        }) ?? 0
        
        return index
    }
    
    func addItem(food: Post) {
        print(food)
        if var favorite = self.favorite {
            if(favorite.count >= 40){
                favorite.removeLast()
            }
            favorite.append(food)
            self.favorite = favorite
        } else {
            self.favorite = [food]
        }
        
    }
    
    @MainActor
    func fetchPosts() async throws {
        showProgressFlag = true
        self.posts = try await PostService.fetchFeedPosts(cate: selectCate)
        self.displaying_posts = self.posts.shuffled()
        
        
        guard displaying_posts != nil else {
            return
        }
//        for post in dispPosts{
//            print(post.title)
//        }
        showProgressFlag = false
    }
}
