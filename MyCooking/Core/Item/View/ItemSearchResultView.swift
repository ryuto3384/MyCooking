//
//  ItemSearchResultView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/08.
//

import SwiftUI

struct ItemSearchResultView: View {
    var body: some View {
        HStack{
            VStack{
               Text("Title")
                Text("食材")
                Text("アカウント")
            }
            Image(.syumagi1)
                .resizable()
                .scaledToFill()
                .frame(width: 130,height: 130)
                .clipped()
        }
        
    }
}

#Preview {
    ItemSearchResultView()
}
