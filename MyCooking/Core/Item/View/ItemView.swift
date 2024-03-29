//
//  ItemView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

struct ItemView: View {
    
    @State private var searchText = ""
    @State private var isActive: Bool = false
    
    let categories:[String] = RecipeCategory.allCases.map{ $0.rawValue }
    
    @EnvironmentObject var viewModel: MainTabViewModel
    
    var body: some View {
        //グラデーション
        /*let gradient: LinearGradient = LinearGradient(
            gradient: Gradient(colors: [Color("MainGradient1-1"), Color("MainGradient1-2")]), startPoint:.top, endPoint: .bottom)*/
        
        NavigationStack {
            ZStack{
                /*gradient
                    .edgesIgnoringSafeArea(.all):*/
                
                ScrollView{
                    LazyVStack{
                        
                        SearchBar(text: $searchText)
                        
                        
                        
                        VStack{
                            Text("キーワード")
                                .font(.title)
                                //.foregroundStyle(Color("TextColor1"))
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                //.shadow(color: .black.opacity(0.75), radius: 3, x: 2, y: 2)
                                .padding(.horizontal)
                            
                            
                            ItemHeaderView()
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                        }
                        ForEach(categories, id: \.self) { category in
                            ItemScrollView(category: category)
                                .padding(.horizontal)
                        }
                    }
                    
                    
                }
                
                
                .blur(radius: viewModel.showProgressFlag ? 3 : 0)
                .disabled(viewModel.showProgressFlag)
                //ツイッターのような更新
                .refreshable{
                    do {
                        Task {
                            try await viewModel.fetchAllPosts()
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
    ItemView()
}
