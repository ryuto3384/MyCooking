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
        let snapshot = try await postsCollection.whereField("ownerUid", isEqualTo: uid).order(by: "timestamp", descending: true).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
    }
    
    static func fetchUserFavoritePosts(id: [String]) async throws -> [Post] {
        if !id.isEmpty {
            let snapshot = try await postsCollection.whereField("id", in: id).getDocuments()
            return try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
        } else {
            return []
        }
    }
    
    
    static func fetchPost(id: String) async throws -> Post {
        let document = postsCollection.document(id)
       let snapshot = try await document.getDocument()
       return try snapshot.data(as: Post.self)
    }
    
    
    static func deletePost(id: String) async throws {
        do {
            let document = postsCollection.document(id)

            try await document.delete()

            //print("Document successfully deleted")
        } catch {
            print("DEBUG ERROR: \(error)")
            throw error
        }
    }
    
}
