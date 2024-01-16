//
//  HomeSelectedCategoryView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/16.
//

import SwiftUI

struct HomeSelectedCategoryView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    private let gridItem : [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    let categories = RecipeCategory.allCases
    
    
    var body: some View {
        VStack{
            ScrollView{
                LazyVGrid(columns: gridItem, spacing: 2){
                    ForEach(categories, id: \.self) { category in
                        Button{
                            viewModel.selectCate = category.rawValue
                            dismiss()
                            Task{
                                try await viewModel.fetchPosts()
                            }
                        } label: {
                            Text(category.rawValue)
                                .padding()
                                .frame(width: 150, height: 60)
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .cornerRadius(25)
                        }
                        
                        
                    }
                }
            }
        }
        .padding(20)
        
    }
}

#Preview {
    HomeSelectedCategoryView()
}
