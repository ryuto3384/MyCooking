//
//  User.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI
import Firebase

struct User: Identifiable,Hashable, Codable {
    var id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
    var follow: Int
    var followers: Int
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false}
        return currentUid == id
    }
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "syumagi", profileImageUrl: "nil", fullname: "Syuden Magiwa", bio: "Dark", email: "syumagi@gmail.com", follow: 1, followers: 1),
        .init(id: NSUUID().uuidString, username: "syumagi2", profileImageUrl: "nil", fullname: nil, bio: "Dark", email: "syumagi2@gmail.com", follow: 2, followers: 2),
        .init(id: NSUUID().uuidString, username: "syumagi3", profileImageUrl: "nil", fullname: "Syuden Magiwa3", bio: "Dark", email: "syumagi3@gmail.com", follow: 3, followers: 3)
    ]
}
