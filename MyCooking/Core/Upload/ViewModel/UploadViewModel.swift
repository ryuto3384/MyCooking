//
//  UploadViewModel.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/05.
//

import SwiftUI
import PhotosUI
import Firebase

//非同期の値をメインスレッドに送る役割？
@MainActor
class UploadViewModel: ObservableObject {
    
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
    
    func uploadPost(title: String, introduction: String, methodValues: [String], ingredientsPeople: String, ingredientsValues: [String], ingredientsAmount: [String], category: [String]) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else { return }

        let postRef = Firestore.firestore().collection("posts").document()

        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { return }
        let post = Post(id: postRef.documentID, ownerUid: uid, title: title, introduction: introduction, methodValues: methodValues, ingredientsPeople: ingredientsPeople,ingredientsValues: ingredientsValues, ingredientsAmount: ingredientsAmount, likes: 0, imageUrl: imageUrl, timestamp: Timestamp(), category: category )
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
        
        try await postRef.setData(encodedPost)
    }
    
    func updateCount(user: User) async throws {
        var data = [String: Any]()
        
        var count = user.postCount
        count += 1
        
        data["postCount"] = count
        
        try await Firestore.firestore().collection("users").document(user.id).updateData(data)
    }
}
