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
    @Published var imageURL = ""
    @Published var introduction = ""
    @Published var title = ""
    @Published var methodValues:[String] = []
    @Published var ingredientsPeople = ""
    @Published var ingredientsValues:[String] = []
    @Published var ingredientsAmount:[String] = []
    @Published var selectedCategory:[String] = []
    @Published var showProgressFlag = false
    
    init(post: Post, user: User) {
        
        self.post = post
        
        self.user = user
        
        if user.favoriteList != [] {
            favorite = user.favoriteList
        }
        self.introduction = post.introduction
        self.title = post.title
        self.methodValues = post.methodValues
        self.ingredientsPeople = post.ingredientsPeople
        self.ingredientsValues = post.ingredientsValues
        self.ingredientsAmount = post.ingredientsAmount
        self.selectedCategory = post.category
        self.imageURL = post.imageUrl
        
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
    
    @MainActor
    func updateRecipe() async throws {
        var data = [String: Any]()
        
        if let uiImage = uiImage {
            let imageUrl = try? await ImageUploader.uploadImage(image: uiImage)
            data["imageUrl"] = imageUrl
        }
        
        if post.introduction != introduction {
            data["introduction"] = introduction
        }

        if post.title != title {
            data["title"] = title
        }

        if post.methodValues != methodValues {
            data["methodValues"] = methodValues
        }
        if post.ingredientsPeople != ingredientsPeople {
            data["ingredientsPeople"] = ingredientsPeople
        }
        if post.ingredientsValues != ingredientsValues {
            data["ingredientsValues"] = ingredientsValues
        }
        if post.ingredientsAmount != ingredientsAmount {
            data["ingredientsAmount"] = ingredientsAmount
        }
        
        if post.category != selectedCategory {
            data["category"] = selectedCategory
        }
        
        
        if !data.isEmpty {
            //print("呼び出された")
            try await Firestore.firestore().collection("posts").document(post.id).updateData(data)
        }
        
        self.post = try await PostService.fetchPost(id: post.id)
        
    }
    
    func deleteRecipe() async throws {
        try await PostService.deletePost(id: post.id)
    }
    
    func updateCount(user: User) async throws {
        var data = [String: Any]()
        
        var count = user.postCount
        count -= 1
        
        data["postCount"] = count
        
        try await Firestore.firestore().collection("users").document(user.id).updateData(data)
    }
}
