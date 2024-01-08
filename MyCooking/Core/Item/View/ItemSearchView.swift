//
//  ItemSearchView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/08.
//

import SwiftUI

enum SearchOption: String, CaseIterable {
    case ascending = "新しい順"
    case descending = "古い順"
}

struct ItemSearchView: View {
    
    @State private var selectedOption = SearchOption.ascending
    
    let category: String
    let posts: [Post]
    
    var body: some View {
        VStack{
            Picker("検索オプション", selection: $selectedOption){
                ForEach(SearchOption.allCases, id: \.self) { option in
                    Text(option.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            //下に色々
            List {
                ForEach(posts.filter{ $0.category == category}){ post in
                    NavigationLink(destination: showRecipeView(user: post.user ?? User.MOCK_USERS[0], post: post)){
                        ItemSearchResultView(post: post)
                    }
                }
                
            }
            .listStyle(.inset)
        }
    }
}
