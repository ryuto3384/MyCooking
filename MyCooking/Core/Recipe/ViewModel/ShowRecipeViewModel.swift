//
//  ShowRecipeViewModel.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/06.
//

import SwiftUI
import PhotosUI
import Firebase

class ShowRecipeViewModel: ObservableObject{
    @Published var post: Post
    @Published var user: User
    @Published var favorite = [String]()
    
    init(post: Post, user: User) {
        
        self.post = post
        
        self.user = user
        
        if user.favoriteList != [] {
            favorite = user.favoriteList
        }
    }
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task {await loadImage(fromItem: selectedImage)}}
    }
    @Published var postImage: Image?
    private var uiImage: UIImage?
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
        
    }
    
    @MainActor
    func updateUserData(postId: String) async throws {
        
        var data = [String: Any]()
        
        if favorite.contains(postId) {
            favorite.removeAll(where: {$0 == postId })
            
        } else {
            favorite.append(postId)
        }
        
        data["favoriteList"] = favorite
        
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }
}
