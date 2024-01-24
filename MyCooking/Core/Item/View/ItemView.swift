//
//  ItemView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

struct ItemView: View {
    
    @State private var searchText = ""
    
    let categories:[String] = RecipeCategory.allCases.map{ $0.rawValue }
    
    @StateObject var viewModel = ItemViewModel()

    var body: some View {
        if viewModel.fetchTime {
            ProgressView("Now loading")
        } else {
            NavigationStack {
                ScrollView{
                    LazyVStack{
                        VStack{
                            Text("キーワード")
                                .font(.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            
                            ItemHeaderView(posts: viewModel.posts)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                        }
                        ForEach(categories, id: \.self) { category in
                            ItemScrollView(category: category, posts: viewModel.posts)
                                .padding(.horizontal)
                        }
                    }
                    .searchable(text: $searchText,prompt: "レシピ検索")
                }
                //ツイッターのような更新
                .refreshable{
                    do {
                        Task {
                            try await viewModel.fetchPosts()
                        }
                    }
                }
            }
        }
        
        
    }
}

#Preview {
    ItemView()
}
