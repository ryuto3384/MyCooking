//
//  UploadView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

import PhotosUI

struct UploadView: View {
    
    @State private var caption = ""
    @State private var imagePickerPresented = false
    @State private var photoItem: PhotosPickerItem?
    
    @StateObject var viewModel = UploadViewModel()
    
    @Binding var tabIndex: Int
    
    var body: some View {
        VStack {
            //ツールバー
            HStack {
                Button {
                    clearPostDateAndReturnToFeed()
                } label: {
                     Text("閉じる")
                        
                }
                
                Spacer()
                Text("レシピを書く")
                    .fontWeight(.semibold)
                Spacer()
                
                Button {
                    Task {
                        try await viewModel.uploadPost(caption: caption)
                        clearPostDateAndReturnToFeed()
                    }
                } label: {
                     Text("投稿")
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal)

            //postImage and caption
            HStack(spacing: 8) {
                if let image = viewModel.postImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                }
                
                TextField("Enter your caption...", text: $caption, axis: .vertical)
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            //imagePickerPresented.toggle()
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
    
    func clearPostDateAndReturnToFeed() {
        caption = ""
        viewModel.postImage = nil
        viewModel.selectedImage = nil
        tabIndex = 2
    }
    
}

#Preview {
    UploadView(tabIndex: .constant(0))
}
