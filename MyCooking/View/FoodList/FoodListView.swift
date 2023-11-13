//
//  FoodListView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2023/09/13.
//

import SwiftUI

struct FoodListView: View {
    
    @State private var searchText: String = ""
    
    var body: some View {
        Form {
            Section{
                SearchView(text: $searchText)
            }
            
            Section{
                PopularPageView()
                    .frame(maxWidth: .infinity, maxHeight: 300)
            }
            Section{
                PopularTagView()
                    .frame(maxWidth: .infinity, maxHeight: 500)
            }
            
        }
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView()
    }
}
