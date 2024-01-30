//
//  MainTabViewModel.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/25.
//

import SwiftUI
import PhotosUI
import Firebase

@MainActor
class MainTabViewModel: ObservableObject {
    //ログインしているユーザー
    @Published var curUser: User
    //すべてのpost
    @Published var allPosts = [Post]()
    //すべてuser
    @Published var allUsers = [User]()
    
    
    @Published var userPosts: [Post]?
    @Published var displaying_posts: [Post]?
    @Published var favorite: [Post]?
    @Published var userFavorite: [String]
    @Published var post: Post?
    @Published var showProgressFlag: Bool = false
    @Published var profileImage: Image?
    @Published var fullname = ""
    @Published var bio = ""
    @Published var selectCate = ""
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task {await loadImage(fromItem: selectedImage)}}
    }
    @Published var postImage: Image?
    private var uiImage: UIImage?
    
    init(user: User){
        self.curUser = user
        
        if let fullname = user.fullname {
            self.fullname = fullname
        }
        
        if let bio = user.bio {
            self.bio = bio
        }
        self.userFavorite = user.favoriteList
        
        Task { try await fetchAllData() }
    }
    
    //すべてのuser,postを取得する
    @MainActor
    func fetchAllData() async throws {
        showProgressFlag = true
        self.allUsers = try await UserService.fetchAllUsers()
        self.allPosts = try await PostService.fetchFeedPosts(cate: selectCate)
        self.displaying_posts = self.allPosts.shuffled()
        
        
        guard displaying_posts != nil else {
            return
        }
        showProgressFlag = false
    }
    
    //すべてのpostの取得
    @MainActor
    func fetchAllPosts() async throws {
        showProgressFlag = true
        self.allPosts = try await PostService.fetchFeedPosts(cate: selectCate)
        showProgressFlag = false
    }
    
    //すべてのuserを取得する
    @MainActor
    func fetchAllUsers() async throws {
        showProgressFlag = true
        self.allUsers = try await UserService.fetchAllUsers()
        showProgressFlag = false
    }
    
    //ログインしているuserの情報を取得する
    func fetchCurUser() async throws {
        showProgressFlag = true
        self.curUser = try await UserService.fetchUser(withUid: curUser.id)
        showProgressFlag = false
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    
    
    
    
    func getIndex(food: Post) -> Int {
        let index = displaying_posts?.lastIndex(where: { currentFood in
            return food.id == currentFood.id
        }) ?? 0
        
        return index
    }
    
    func addItem(food: Post) {
        print(food)
        if var favorite = self.favorite {
            if(favorite.count >= 40){
                favorite.removeLast()
            }
            favorite.append(food)
            self.favorite = favorite
        } else {
            self.favorite = [food]
        }
        
    }
    
    @MainActor
    func fetchPosts() async throws {
        showProgressFlag = true
        self.allPosts = try await PostService.fetchFeedPosts(cate: selectCate)
        self.displaying_posts = self.allPosts.shuffled()
        
        
        guard displaying_posts != nil else {
            return
        }

        showProgressFlag = false
    }
    
    func updateCount(user: User) async throws {
        var data = [String: Any]()
        
        var count = user.postCount
        count += 1
        
        data["postCount"] = count
        
        try await Firestore.firestore().collection("users").document(user.id).updateData(data)
    }
    
    @MainActor
    func uploadPost(title: String, introduction: String, methodValues: [String], ingredientsPeople: String, ingredientsValues: [String], ingredientsAmount: [String], category: [String]) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else { return }

        let postRef = Firestore.firestore().collection("posts").document()

        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { return }
        let post = Post(id: postRef.documentID, ownerUid: uid, title: title, introduction: introduction, methodValues: methodValues, ingredientsPeople: ingredientsPeople,ingredientsValues: ingredientsValues, ingredientsAmount: ingredientsAmount, likes: 0, imageUrl: imageUrl, timestamp: Timestamp(), category: category )
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
        
        try await postRef.setData(encodedPost)
    }
    
    func createEditUser() {
        if let fullname = curUser.fullname {
            self.fullname = fullname
        }
        
        if let bio = curUser.bio {
            self.bio = bio
        }
        self.userFavorite = curUser.favoriteList
    }
    
    func fetchUserData() async throws {
        self.curUser = try await UserService.fetchUser(withUid: curUser.id)
        self.userPosts = try await PostService.fetchUserPosts(uid: self.curUser.id)
        self.curUser.postCount = allPosts.count
        
        for i in 0 ..< allPosts.count {
            allPosts[i].user = self.curUser
        }
    }
    
    func registFollow() async throws {
        try await ProfileAuthService.shared.loadUserData()
        try await ProfileAuthService.shared.registFollow(user: curUser)
        self.curUser = try await ProfileAuthService.shared.loadWatchUserData(user: curUser)
        
    }
    
    func deleteFollow() async throws {
        try await ProfileAuthService.shared.loadUserData()
        try await ProfileAuthService.shared.deleteFollow(user: curUser)
        self.curUser = try await ProfileAuthService.shared.loadWatchUserData(user: curUser)
        
    }
    
    func checkFollow() -> Bool {
        return ProfileAuthService.shared.checkFollow(user: self.curUser)
    }
    
    func deleteRecipe() async throws {
        guard let post = self.post else {return}
        try await PostService.deletePost(id: post.id)
    }
    
    func updateUserData(postId: String = "" ) async throws {
        var data = [String: Any]()
        
        if let uiImage = uiImage {
            let imageUrl = try? await ImageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
        }
        if postId != ""{
            if userFavorite.contains(postId) {
                userFavorite.removeAll(where: {$0 == postId })
                
            } else {
                userFavorite.append(postId)
            }
            
            data["favoriteList"] = favorite
        }
        
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(curUser.id).updateData(data)
        }
        
        //update name if changed
        if !fullname.isEmpty && curUser.fullname != fullname {
            data["fullname"] = fullname
        }
        
        //update bio if changed
        if !bio.isEmpty && curUser.bio != bio {
            data["bio"] = bio
        }
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(curUser.id).updateData(data)
        }
    }
    

}

