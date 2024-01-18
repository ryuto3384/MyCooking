//
//  ProfileAuthService.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/18.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

class ProfileAuthService {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = ProfileAuthService()
    
    init() {
        Task { try await loadUserData() }
    }
    
    @MainActor
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        guard let currentUid = userSession?.uid else { return }
        self.currentUser = try await UserService.fetchUser(withUid: currentUid)
    }
    
    @MainActor
    func loadWatchUserData(user: User) async throws -> User {
        return try await UserService.fetchUser(withUid: user.id)
    }
    
    @MainActor
    func registFollow(user: User) async throws {
        var user = user
        
        var userdata = [String: Any]()
        var currentuserdata = [String: Any]()
        
        guard var current = currentUser else {
            print("DEBUG: currentUserがいません")
            return
        }
        
        user.followers.append(current.id)
        current.follow.append(user.id)
        
        userdata["followers"] = user.followers
        currentuserdata["follow"] = current.follow
        
        if !userdata.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(userdata)
        }
        if !currentuserdata.isEmpty {
            try await Firestore.firestore().collection("users").document(current.id).updateData(currentuserdata)
        }
        
    }
    
    @MainActor
    func deleteFollow(user: User) async throws {
        var user = user
        
        var userdata = [String: Any]()
        var currentuserdata = [String: Any]()
        
        guard var current = currentUser else {
            print("DEBUG: currentUserがいません")
            return
        }
        
        user.followers.removeAll(where: {$0 == current.id })
        current.follow.removeAll(where: {$0 == user.id })
        
        userdata["followers"] = user.followers
        currentuserdata["follow"] = current.follow
        
        if !userdata.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(userdata)
        }
        if !currentuserdata.isEmpty {
            try await Firestore.firestore().collection("users").document(current.id).updateData(currentuserdata)
        }
//
//        print("----------------------------------------------")
//        print("終了")
//        print("----------------------------------------------")
        
    }
    
    func checkFollow(user: User) -> Bool {
        if let uid = currentUser?.id {
            if user.followers.contains(uid) {
                return true
            } else {
                return false
            }
        }
        return false
    }
}
