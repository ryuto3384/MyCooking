//
//  HomeFavoriteView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/09.
//

import SwiftUI

struct HomeFavoriteView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack{
            Button{
                dismiss()
            }label: {
                Text("閉じる")
            }
            if let favoriteFoods = viewModel.favorite{
                ResultListView(posts: favoriteFoods, category: "")
            }
        }
            
    }
}
