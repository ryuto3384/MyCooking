//
//  HomeFavoriteView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/09.
//

import SwiftUI

struct HomeFavoriteView: View {
    
    @EnvironmentObject var viewModel: MainTabViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack{
            HStack{
                Button{
                    dismiss()
                }label: {
                    Image(systemName: "x.circle")
                        .font(.system(size: 30))
                        .foregroundStyle(.black)
                }
                Spacer()
            }
            
            if viewModel.favorite != nil{
                ResultListView(category: "")
            } else {
                Text("いいねしたレシピがありません")
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
            
    }
}
