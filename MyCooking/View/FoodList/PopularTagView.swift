//
//  PopularTagView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2023/09/13.
//

import SwiftUI

struct PopularTagView: View {
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    //textはimageになる
                    Text("写真")
                        .frame(width: 100, height: 100)
                    //今だけわかりやすいようにつけている
                        .background(.gray)
                    
                    //textはimageになる
                    Text("写真")
                        .frame(width: 100, height: 100)
                    //今だけわかりやすいようにつけている
                        .background(.gray)
                    
                    //textはimageになる
                    Text("写真")
                        .frame(width: 100, height: 100)
                    //今だけわかりやすいようにつけている
                        .background(.gray)
                    
                }
                HStack{
                    //textはimageになる
                    Text("写真")
                        .frame(width: 100, height: 100)
                    //今だけわかりやすいようにつけている
                        .background(.gray)
                    
                    //textはimageになる
                    Text("写真")
                        .frame(width: 100, height: 100)
                    //今だけわかりやすいようにつけている
                        .background(.gray)
                    
                    //textはimageになる
                    Text("写真")
                        .frame(width: 100, height: 100)
                    //今だけわかりやすいようにつけている
                        .background(.gray)
                    
                }
                HStack{
                    //textはimageになる
                    Text("写真")
                        .frame(width: 100, height: 100)
                    //今だけわかりやすいようにつけている
                        .background(.gray)
                    
                    //textはimageになる
                    Text("写真")
                        .frame(width: 100, height: 100)
                    //今だけわかりやすいようにつけている
                        .background(.gray)
                    
                    //textはimageになる
                    Text("写真")
                        .frame(width: 100, height: 100)
                    //今だけわかりやすいようにつけている
                        .background(.gray)
                    
                }
            }.navigationTitle("人気のタグ")
        }
    }
}

struct PopularTagView_Previews: PreviewProvider {
    static var previews: some View {
        PopularTagView()
    }
}
