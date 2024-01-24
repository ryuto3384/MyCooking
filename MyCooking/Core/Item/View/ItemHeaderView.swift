//
//  ItemHeaderView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/08.
//

import SwiftUI

struct ItemHeaderView: View {
    
    private let gridItem : [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    let categories:[String]  = RecipeCategory.allCases.map{ $0.rawValue }
    
    let posts: [Post]
    
    var body: some View {
        let shuffledCategory = categories.shuffled().prefix(9)
        
        VStack {
            LazyVGrid(columns: gridItem, spacing: 1){
                ForEach(shuffledCategory, id: \.self) { category in
                    NavigationLink(destination: ItemSearchView(category: category, posts: posts)){
                        Text(category)
                            .frame(maxWidth: 200, minHeight: 60)
                            .background(Color(.black))
                            .foregroundStyle(Color.white)
                            .cornerRadius(10)
                    }
                    
                        
                        
                }
            }
        }
    }
}
