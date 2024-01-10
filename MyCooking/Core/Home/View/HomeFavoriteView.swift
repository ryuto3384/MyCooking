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
        let _ = print(viewModel.favorite?.count ?? 0)
        VStack{
            Button{
                dismiss()
            }label: {
                Text("閉じる")
            }
            ScrollView{
                VStack{
                    if let favoriteFoods = viewModel.favorite{
                        ForEach(favoriteFoods) { food in
                            Text(food.title)
                            Divider()
                        }
                    }
                    
                }
            }
        }
    }
}
