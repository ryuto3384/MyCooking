//
//  ItemSearchTextView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/25.
//

import SwiftUI

struct ItemSearchTextView: View {
    
    @State private var selectedOption = SearchOption.ascending
    @Environment(\.dismiss) var dismiss
    
    let searchText: String
    let posts: [Post]
    
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
            }.padding(.horizontal, 8)
                .padding(.top, 15)
            
            
            Picker("検索オプション", selection: $selectedOption){
                ForEach(SearchOption.allCases, id: \.self) { option in
                    Text(option.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            ResultTextListView(posts: posts, searchText: searchText)
            Spacer()
        }
    }
}

#Preview {
    ItemSearchTextView(searchText: "卵", posts: Post.MOCK_POSTS)
}

