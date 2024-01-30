//
//  ProfileViewModel.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/21.
//

import SwiftUI
import PhotosUI
import Firebase

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var posts = [Post]()
    @Published var post: Post?
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task {await loadImage(fromItem: selectedImage)}}
    }
    @Published var profileImage: Image?
    @Published var fullname = ""
    @Published var bio = ""
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
    
    @Published var postImage: Image?
    private var uiImage: UIImage?
    
    init(user: User) {
        self.user = user
        Task {
            try await fetchUserPosts()
        }
        if let fullname = user.fullname {
            self.fullname = fullname
        }
        
        if let bio = user.bio {
            self.bio = bio
        }
        self.favorite = user.favoriteList
        
        
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func fetchUsers() async throws {
        self.user = try await UserService.fetchUser(withUid: user.id)
        self.posts = try await PostService.fetchUserPosts(uid: self.user.id)
        self.user.postCount = posts.count
    }
    
    func fetchUserPosts() async throws{
        
        self.posts = try await PostService.fetchUserPosts(uid: self.user.id)
        
        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
        self.user.postCount = posts.count
        
    }
    
    func updateUserData(postId: String = "" ) async throws {
        var data = [String: Any]()
        
        if let uiImage = uiImage {
            let imageUrl = try? await ImageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
        }
        if postId != ""{
            if favorite.contains(postId) {
                favorite.removeAll(where: {$0 == postId })
                
            } else {
                favorite.append(postId)
            }
            
            data["favoriteList"] = favorite
        }
        
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
        
        //update name if changed
        if !fullname.isEmpty && user.fullname != fullname {
            data["fullname"] = fullname
        }
        
        //update bio if changed
        if !bio.isEmpty && user.bio != bio {
            data["bio"] = bio
        }
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }
    
    func registFollow() async throws {
        try await ProfileAuthService.shared.loadUserData()
        try await ProfileAuthService.shared.registFollow(user: user)
        self.user = try await ProfileAuthService.shared.loadWatchUserData(user: user)
        
    }
    
    func deleteFollow() async throws {
        try await ProfileAuthService.shared.loadUserData()
        try await ProfileAuthService.shared.deleteFollow(user: user)
        self.user = try await ProfileAuthService.shared.loadWatchUserData(user: user)
        
    }
    
    func checkFollow() -> Bool {
        return ProfileAuthService.shared.checkFollow(user: self.user)
    }
    
    func showPost(post: Post) {
        self.post = post
        self.introduction = post.introduction
        self.title = post.title
        self.methodValues = post.methodValues
        self.ingredientsPeople = post.ingredientsPeople
        self.ingredientsValues = post.ingredientsValues
        self.ingredientsAmount = post.ingredientsAmount
        self.selectedCategory = post.category
        self.imageURL = post.imageUrl
    }
    
    func updateRecipe() async throws {
        guard let post = self.post else {return}
        
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
        guard let post = self.post else {return}
        try await PostService.deletePost(id: post.id)
    }
    
}

