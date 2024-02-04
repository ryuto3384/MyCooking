//
//  TicktokView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText = ""
    @EnvironmentObject var viewModel: MainTabViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    if searchText == "" {
                        ForEach(viewModel.allUsers.filter( {$0.id != viewModel.curUser.id} )){ user in
                            
                            NavigationLink(value: user) {
                                HStack{
                                    CircularProfileImageView(user: user, size: .xSmall)
                                    
                                    VStack(alignment: .leading){
                                        Text(user.username)
                                            .fontWeight(.semibold)
                                        
                                        if let fullname = user.fullname {
                                            Text(fullname)
                                        }
                                    }
                                    .font(.footnote)
                                    
                                    
                                    Spacer()
                                    
                                }
                                .foregroundStyle(.black)
                                .padding(.horizontal)
                            }
                            
                            
                            
                        }
                    } else {
                        ForEach(viewModel.allUsers.filter{ user in
                            return user.username.lowercased().contains(searchText.lowercased())
                        }) { user in
                            
                            NavigationLink(value: user) {
                                HStack{
                                    CircularProfileImageView(user: user, size: .xSmall)
                                    
                                    VStack(alignment: .leading){
                                        Text(user.username)
                                            .fontWeight(.semibold)
                                        
                                        if let fullname = user.fullname {
                                            Text(fullname)
                                        }
                                    }
                                    .font(.footnote)
                                    
                                    
                                    Spacer()
                                    
                                }
                                .foregroundStyle(.black)
                                .padding(.horizontal)
                            }
                            
                            
                            
                        }
                    }
                    
                }
                .padding(.top, 8)
                .searchable(text: $searchText,prompt: "検索...")
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationTitle("検索")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}
