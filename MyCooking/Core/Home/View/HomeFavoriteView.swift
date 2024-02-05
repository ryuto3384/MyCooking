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
                .padding(.horizontal)
                .padding(.top)
                Spacer()
                
            }
            
            if !viewModel.favorite.isEmpty{
                HomeResultList()
            } else {
                Text("いいねしたレシピがありません")
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        
            
    }
}
