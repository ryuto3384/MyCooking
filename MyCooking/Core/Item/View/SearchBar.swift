//
//  SearchBar.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/25.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @ObservedObject var viewModel: MainTabViewModel
    
    var body: some View {
        VStack {
            
            ZStack {
                // 背景
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 239 / 255,
                                green: 239 / 255,
                                blue: 241 / 255))
                    .frame(height: 36)
                
                HStack(spacing: 6) {
                    Spacer()
                        .frame(width: 0)
                    
                    // 虫眼鏡
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    // テキストフィールド
                    TextField("Search", text: $text)
                    
                    
                    
                    NavigationLink{
                        ItemSearchTextView(searchText: text, posts: viewModel.posts)
                    } label: {
                        Text("検索")
                            .frame(width: 40, height: 36)
                    }
                    .padding(.trailing, 6)
                    
                }
            }
            .padding(.top, 20)
            .padding(.horizontal)
        }
    }
}
