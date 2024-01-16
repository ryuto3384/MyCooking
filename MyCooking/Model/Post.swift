//
//  Post.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI
import Firebase

struct Post: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    let title: String
    let introduction: String
    let methodValues: [String]
    let ingredientsPeople: String
    let ingredientsValues: [String]
    let ingredientsAmount: [String]
    var likes: Int
    let imageUrl: String
    let timestamp: Timestamp
    let category: RecipeCategory.RawValue
    var user: User?
}

extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, title: "", introduction: "This is some test caption for now", methodValues: [""], ingredientsPeople: "", ingredientsValues: [""], ingredientsAmount: [""], likes: 123, imageUrl: "syumagi-1", timestamp: Timestamp(),category: "\(RecipeCategory.breakfast)" ,user: User.MOCK_USERS[0]),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, title: "", introduction: "syumagi-2", methodValues: [""], ingredientsPeople: "", ingredientsValues: [""], ingredientsAmount: [""], likes: 123, imageUrl: "syumagi-2", timestamp: Timestamp(),category: "\(RecipeCategory.breakfast)" , user: User.MOCK_USERS[1]),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, title: "", introduction: "syumagi-3", methodValues: [""], ingredientsPeople: "", ingredientsValues: [""], ingredientsAmount: [""], likes: 123, imageUrl: "syumagi-3", timestamp: Timestamp(),category: "\(RecipeCategory.breakfast)", user: User.MOCK_USERS[2]),
    ]
}

