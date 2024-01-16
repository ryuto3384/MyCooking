//
//  PostService.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI
import Firebase

struct PostService {
    
    private static var postsCollection = Firestore.firestore().collection("posts")
    
    static func fetchFeedPosts(cate: String) async throws -> [Post] {

        if cate == ""{
            let snapshot = try await postsCollection.getDocuments()
            var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
            for i in 0 ..< posts.count {
                let post = posts[i]
                let ownerUid = post.ownerUid
                let postUser = try await UserService.fetchUser(withUid: ownerUid)
                
                posts[i].user = postUser
            }
            
            return posts
        } else {
            let query = postsCollection.whereField("category", isEqualTo: cate)
            let snapshot = try await query.getDocuments()
            var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
            for i in 0 ..< posts.count {
                let post = posts[i]
                let ownerUid = post.ownerUid
                let postUser = try await UserService.fetchUser(withUid: ownerUid)
                
                posts[i].user = postUser
            }
            
            return posts
        }

        
        
    }
    
    static func fetchUserPosts(uid: String) async throws -> [Post] {
        let snapshot = try await postsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
    }
}
