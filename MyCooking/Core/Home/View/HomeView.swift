//
//  HomeView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    @State private var isPresented = false
    @State private var isShowCategory = false
    
    @State var selectCate = ""
    
    private let buttonSize: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                ZStack {
                    if viewModel.showProgressFlag {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    } else {
                        if let foods = viewModel.displaying_posts {
                            if foods.isEmpty {
                                Button{
                                    Task{
                                        try await viewModel.fetchPosts()
                                    }
                                } label: {
                                    Text("更新する")
                                        .font(.caption)
                                        .foregroundStyle(Color.gray)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                }
                                
                                
                            } else {
                                ForEach(foods){ food in
                                    StackCardView(food: food)
                                        .environmentObject(viewModel)
                                }
                            }
                        }
                    }
                }
                .padding()
                
                HStack(spacing: 10){
                    Button{
                        doSwipe()
                    } label: {
                        Text("Bad")
                            .bold()
                            .padding()
                            .frame(width: buttonSize, height: 50)
                            .foregroundColor(Color.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.purple, lineWidth: 3)
                            )
                    }
                    .disabled(viewModel.displaying_posts?.isEmpty ?? false)
                    .opacity((viewModel.displaying_posts?.isEmpty ?? false) ? 0.6 : 1)
                    
                    Button{
                        print("menu")
                        isPresented.toggle()
                    }label: {
                        Image(systemName: "list.bullet.rectangle.portrait")
                            .font(.system(size: 45, weight: .light))
                            .foregroundStyle(Color.black)
                    }
                    Button{
                        doSwipe(rightSwipe: true)
                    }label: {
                        Text("Good")
                            .bold()
                            .padding()
                            .frame(width: buttonSize, height: 50)
                            .foregroundColor(Color.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.purple, lineWidth: 3)
                            )
                    }
                    .disabled(viewModel.displaying_posts?.isEmpty ?? false)
                    .opacity((viewModel.displaying_posts?.isEmpty ?? false) ? 0.6 : 1)
                    
                    
                }
                .padding(.horizontal)
                .padding(.bottom, 100)
                .padding(.top, 10)
                
                
            }
            .sheet(isPresented: $isPresented) {
                NavigationStack{
                    HomeFavoriteView()
                }
                .environmentObject(viewModel)
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        print("種類の変更")
                        isShowCategory.toggle()
                    }label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .sheet(isPresented: $isShowCategory){
                        HomeSelectedCategoryView()
                            .presentationDetents([.medium])
                            .environmentObject(viewModel)
                    }
                }
            }
        }
        
    }
    
    func doSwipe(rightSwipe: Bool = false) {
        guard let last = viewModel.displaying_posts?.last else{
            return
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
            "id" : last.id,
            "rightSwipe" : rightSwipe
        ])
    }
    
    func CardPrint(){
        print("-----------------------------------------------")
        print(viewModel.displaying_posts?.count ?? 0)
        print("-----------------------------------------------")
    }
}

#Preview {
    HomeView()
}
