//
//  HomeResultList.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/02/05.
//

import SwiftUI

struct HomeResultList: View {
    
    @EnvironmentObject var viewModel: MainTabViewModel
    
    private let widthSize: CGFloat = UIScreen.main.bounds.width - 1
    
    var body: some View {
        List {
            ForEach(viewModel.favorite) { post in
                NavigationLink(destination: showRecipeView(post: post)){
                    ResultCellView(post: post)
                        .frame(width: widthSize, height: 130)
                }
            }
            
            
        }
        .toolbar(.hidden, for: .navigationBar)
        //.navigationBarHidden(true)
        .listStyle(.inset)
    }
}
