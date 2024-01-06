//
//  ShowRecipeViewModel.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/06.
//

import SwiftUI
import PhotosUI

class ShowRecipeViewModel: ObservableObject{
    
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
}
