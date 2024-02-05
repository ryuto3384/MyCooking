//
//  ItemHeaderView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/08.
//

import SwiftUI

struct ItemHeaderView: View {
    
    private let gridItem: [GridItem] = Array(repeating: .init(.flexible(), spacing: 5), count: 3)
    
    let categories:[String]  = RecipeCategory.allCases.map{ $0.rawValue }
    
    var body: some View {
        let gradient: LinearGradient = LinearGradient(
            gradient: Gradient(colors: [Color("Gradient3-2"), Color("Gradient3-3")]), startPoint:.topLeading, endPoint: .bottomTrailing)
        
        let shuffledCategory = categories.shuffled().prefix(9)
        
        VStack {
            LazyVGrid(columns: gridItem, spacing: 5){
                ForEach(shuffledCategory, id: \.self) { category in
                    NavigationLink(destination: ItemSearchView(category: category)){
                        Text(category)
                            .frame(maxWidth: 200, minHeight: 75)
                            .background(gradient)
                            .foregroundStyle(Color("TextColor1"))
                            //.foregroundStyle(.black)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.75), radius: 3, x: 2, y: 2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                    .shadow(color: .white.opacity(0.75), radius: 1, x: -1, y: -1)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            )
                    }
                    
                    
                    
                }
            }
        }
    }
}

#Preview {
    ItemView()
}
