//
//  UserService.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI
import Firebase

struct UserService {

    static func fetchUser(withUid uid: String) async throws -> User {
        
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()

        return try snapshot.data(as: User.self)
    }

    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        //compacMapは配列からnilのデータを取り除く場合に使用する
        return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
    }
}
