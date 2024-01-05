//
//  SerchViewModel.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/05.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchAllUsers() }
    }
    
    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
    }
}
