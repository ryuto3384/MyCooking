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
    //homeで表示するカード
    @Published var displaying_posts: [Post]?
    //フルネーム
    @Published var fullname = ""
    //詳細
    @Published var bio = ""
    //homeのカテゴリーfilter用
    @Published var selectCate = ""
    //非同期処理中を表す
    @Published var showProgressFlag: Bool = false
    //画像系
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task {await loadImage(fromItem: selectedImage)}}
    }
    @Published var postImage: Image?
    private var uiImage: UIImage?
    //userのfavorite
    @Published var userFavorite: [String]
    //homeのmenu用
    @Published var favorite: [Post]?
    //userのposts
    @Published var userPosts: [Post]?
    
    
    
    
    
    
    @Published var post: Post?
    
    @Published var profileImage: Image?
    
        
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
    func fetchAllPosts() async throws {
        showProgressFlag = true
        self.allPosts = try await PostService.fetchFeedPosts(cate: selectCate)
        showProgressFlag = false
    }
    //displayに表示するものをランダムにする
    func fetchPosts() {
        if self.selectCate == "" {
            self.displaying_posts = self.allPosts.shuffled()
        } else {
            let filterPosts = self.allPosts.filter { post in
                return post.category.contains(selectCate)
            }
            self.displaying_posts = filterPosts.shuffled()
        }
        
        guard displaying_posts != nil else {
            return
        }
    }
    
    //すべてのuserを取得する
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
    
    //userの情報を取得
    func fetchUserData() async throws {
        var data = [String: Any]()
        showProgressFlag = true
        self.curUser = try await UserService.fetchUser(withUid: curUser.id)
        self.userPosts = try await PostService.fetchUserPosts(uid: self.curUser.id)
        data["postCount"] = self.userPosts?.count ?? 0
        try await Firestore.firestore().collection("users").document(curUser.id).updateData(data)
        showProgressFlag = false
    }
    
    //アップロード
    func uploadPost(title: String, introduction: String, methodValues: [String], ingredientsPeople: String, ingredientsValues: [String], ingredientsAmount: [String], category: [String]) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else { return }

        let postRef = Firestore.firestore().collection("posts").document()

        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { return }
        let post = Post(id: postRef.documentID, ownerUid: uid, title: title, introduction: introduction, methodValues: methodValues, ingredientsPeople: ingredientsPeople,ingredientsValues: ingredientsValues, ingredientsAmount: ingredientsAmount, likes: 0, imageUrl: imageUrl, timestamp: Timestamp(), category: category )
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
        
        try await postRef.setData(encodedPost)
    }

    
    //フォロ-しているかの確認
    func checkFollow(_ selectedUserId: String) -> Bool {
        if self.curUser.follow.contains(selectedUserId) {
            return true
        } else {
            return false
        }
    }
    
    //フォローする
    func registFollow(user: User) async throws {
        var user = user
        
        var userdata = [String: Any]()
        var currentuserdata = [String: Any]()
        
        user.followers.append(curUser.id)
        curUser.follow.append(user.id)
        
        userdata["followers"] = user.followers
        currentuserdata["follow"] = curUser.follow
        
        if !userdata.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(userdata)
        }
        if !currentuserdata.isEmpty {
            try await Firestore.firestore().collection("users").document(curUser.id).updateData(currentuserdata)
        }
        
    }
    //フォロー解除
    func deleteFollow(user: User) async throws {
        var user = user
        
        var userdata = [String: Any]()
        var currentuserdata = [String: Any]()
        
        user.followers.removeAll(where: {$0 == curUser.id })
        curUser.follow.removeAll(where: {$0 == user.id })
        
        userdata["followers"] = user.followers
        currentuserdata["follow"] = curUser.follow
        
        if !userdata.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(userdata)
        }
        if !currentuserdata.isEmpty {
            try await Firestore.firestore().collection("users").document(curUser.id).updateData(currentuserdata)
        }  
    }
    //画像のロード
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }

    
    
    
    
//----------------------------------------------------------------------------------------
    //選択したuserの情報を更新
    func fetchSelectedUser(selectUserId: String) async throws -> User{
        showProgressFlag = true
        
        let selectUser = try await UserService.fetchUser(withUid: selectUserId)
        
        showProgressFlag = false
        return selectUser
    }
    //homeのカード管理
    func getIndex(food: Post) -> Int {
        let index = displaying_posts?.lastIndex(where: { currentFood in
            return food.id == currentFood.id
        }) ?? 0
        
        return index
    }
    
    //menuに追加するもの
    func addItem(food: Post) {
        //print(food)
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
    
//----------------------------------------------------------------------------------------
    
    
    
    
    

    
    
    
    
    

    

    

    

    
    
    func createEditUser() {
        if let fullname = curUser.fullname {
            self.fullname = fullname
        }
        
        if let bio = curUser.bio {
            self.bio = bio
        }
        self.userFavorite = curUser.favoriteList
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

