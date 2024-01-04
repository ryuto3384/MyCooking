//
//  ItemView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

struct ItemView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack{
                    VStack{
                        Text("Title")
                            .font(.title)
                        HStack{
                            Button("a"){}
                            Button("b"){}
                            Button("c"){}
                        }
                    }
                    VStack{
                        Text("Title")
                            .font(.title)
                        HStack{
                            Button("a"){}
                            Button("b"){}
                            Button("c"){}
                        }
                    }
                    VStack{
                        Text("Title")
                            .font(.title)
                        HStack{
                            Button("a"){}
                            Button("b"){}
                            Button("c"){}
                        }
                    }
                }
                .searchable(text: $searchText,prompt: "Search...")
            }
        }
        
    }
}

#Preview {
    ItemView()
}
