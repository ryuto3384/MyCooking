//
//  RecipeHeader.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/27.
//

import SwiftUI

struct RecipeHeaderView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let postTitle: String
    @State private var showSheet = false
    @Binding var showEditSheet: Bool
    @State private var showMenu = false
    
    @ObservedObject var recipeModel: ShowRecipeViewModel
    @EnvironmentObject var viewModel: MainTabViewModel
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    dismiss()
                } label: {
                    HStack(spacing: 0){
                        
                        Image(systemName: "chevron.backward")
                            .fontWeight(.semibold)
                        Text(" Back")
                        
                    }
                }
                
                Spacer()
                
                Text(postTitle)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.trailing, 15)
                
                Spacer()
                
                Menu {
                    Button {
                        showEditSheet = true
                    } label: {
                        Label("レシピを編集", systemImage: "square.and.pencil")
                        
                    }
                    
                    Button(role: .destructive) {
                        Task {
                            try await recipeModel.deleteRecipe()
                            try await viewModel.fetchUserData()
                        }
                        dismiss()
                    } label: {
                        Label("レシピを削除", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                }
                

                    
            }
            .padding(.top, 15)
            .padding(.horizontal, 8)
        }
        
    }
}

#Preview {
    showRecipeView(post: Post.MOCK_POSTS[0])
}
