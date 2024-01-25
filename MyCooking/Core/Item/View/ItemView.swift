//
//  ItemView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

struct ItemView: View {
    
    @State private var searchText = ""
    @State private var isSearchActive = false
    
    let categories:[String] = RecipeCategory.allCases.map{ $0.rawValue }
    
    @ObservedObject var viewModel: MainTabViewModel
    
    var body: some View {
        NavigationStack {
            ZStack{
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
                    .onChange(of: searchText) { newValue in
                        if !newValue.isEmpty {
                            isSearchActive = true
                        }
                    }
                }
                .navigationDestination(isPresented: $isSearchActive) {
                    ItemSearchTextView(searchText: searchText, posts: viewModel.posts)
                }
                .blur(radius: viewModel.showProgressFlag ? 3 : 0)
                .disabled(viewModel.showProgressFlag)
                //ツイッターのような更新
                .refreshable{
                    do {
                        Task {
                            try await viewModel.fetchPosts()
                        }
                    }
                }
                if viewModel.showProgressFlag {
                    ProgressView("Now loading")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .background(Color.black.opacity(0.2))
                        .zIndex(1)
                }
                
            }
        }
        
        
        
    }
}

#Preview {
    ItemView(viewModel: MainTabViewModel())
}
