//
//  SearchView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2023/09/13.
//

import SwiftUI

struct SearchView: View {

    @Binding var text: String

    var body: some View {
        VStack {

            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 239 / 255,
                                green: 239 / 255,
                                blue: 241 / 255))
                    .frame(height: 36)

                HStack(spacing: 6) {
                    Spacer()
                        .frame(width: 0)

                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)

                    TextField("Search", text: $text)

                    if !text.isEmpty {
                        Button {
                            text.removeAll()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 6)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    
    @State static var searchText: String = ""

    static var previews: some View {
        SearchView(text: $searchText)
    }
}
