//
//  ItemView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

struct ItemView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack{
                    VStack{
                        Text("キーワード")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        ItemHeaderView()
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                    }
                    ForEach(0..<5) { _ in
                        VStack{
                            Text("Title")
                                .font(.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            
                            ItemScrollView()
                            
                        }
                    }
                }
                .searchable(text: $searchText,prompt: "レシピ検索")
            }
        }
        
    }
}

#Preview {
    ItemView()
}
