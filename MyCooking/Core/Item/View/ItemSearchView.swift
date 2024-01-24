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
    @Environment(\.dismiss) var dismiss
    
    let category: String
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
            
            ResultListView(posts: posts, category: category)
            Spacer()
        }
    }
}

#Preview {
    ItemSearchView(category: "朝食", posts: Post.MOCK_POSTS)
}
