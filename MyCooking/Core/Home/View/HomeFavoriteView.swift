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
            Button{
                dismiss()
            }label: {
                Text("閉じる")
            }
            if viewModel.favorite != nil{
                ResultListView(category: "")
            }
        }
            
    }
}
