//
//  ProfileHeaderViewModel.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/18.
//

import SwiftUI
import Firebase


class ProfileHeaderViewModel: ObservableObject {
    @Published var user: User
    @Published var follow = [String]()
    @Published var followers = [String]()
    
    init(user: User) {
        self.user = user
        
        if user.follow != [] {
            self.follow = user.follow
        }
        if user.followers != [] {
            self.followers = user.followers
        }
    }
    
    @MainActor
    func registFollow() async throws {
        try await ProfileAuthService.shared.loadUserData()
        try await ProfileAuthService.shared.registFollow(user: user)
        self.user = try await ProfileAuthService.shared.loadWatchUserData(user: user)

    }
    
    @MainActor
    func deleteFollow() async throws {
        try await ProfileAuthService.shared.loadUserData()
        try await ProfileAuthService.shared.deleteFollow(user: user)
        self.user = try await ProfileAuthService.shared.loadWatchUserData(user: user)

    }
    
    func checkFollow() -> Bool {
        return ProfileAuthService.shared.checkFollow(user: self.user)
    }
    @MainActor
    func loadUser() async throws {
        self.user = try await ProfileAuthService.shared.loadWatchUserData(user: user)
    }
}
