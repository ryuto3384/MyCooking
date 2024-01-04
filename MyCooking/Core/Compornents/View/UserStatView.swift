//
//  UserStatView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

struct UserStatView: View {
    
    let value: Int
    let title: String
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.subheadline)
            
            Text(title)
                .font(.footnote)
                .fontWeight(.semibold)
        }
        .frame(width: 76)
    }
}

#Preview {
    UserStatView(value: 3, title: "Posts")
}
