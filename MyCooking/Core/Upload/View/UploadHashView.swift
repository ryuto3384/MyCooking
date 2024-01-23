//
//  UploadHashView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/21.
//

import SwiftUI

struct UploadHashView: View {
    
    @Binding var selectedTags: [String]
    
    @State private var categories = RecipeCategory.allCases
    @State private var selectedCategory: RecipeCategory? = nil
    
    @Namespace private var animation
    var body: some View {
        VStack(spacing: 0){
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(selectedTags, id: \.self) { tag in
                        TagView(tag, .pink, "checkmark")
                            .matchedGeometryEffect(id: tag, in: animation)
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    selectedTags.removeAll(where: { $0 == tag })
                                }
                            }
                    }
                    
                }
            }
            .padding(.horizontal, 3)
            
            Picker("カテゴリー選択", selection: $selectedCategory) {
                Text("カテゴリーを選択してください")
                    .foregroundStyle(.gray)
                    .tag(Optional<RecipeCategory>.none)
                
                ForEach(categories.filter{ !selectedTags.contains($0.rawValue) }, id: \.self) { category in
                    Text("\(category.rawValue)").tag(Optional.some(category))
                }
            }
            .pickerStyle(.menu)
            .onChange(of: selectedCategory) { newValue in
                
                if let tag = newValue {
                    withAnimation(.snappy) {
                        selectedTags.insert(tag.rawValue, at: 0)
                        selectedCategory = nil
                    }
                }
                
            }
        }
    }
    
    @ViewBuilder
    func TagView(_ tag: String, _ color: Color, _ icon: String) -> some View {
        HStack(spacing: 10) {
            Text(tag)
                .font(.callout)
                .fontWeight(.semibold)
            
            Image(systemName: icon)
        }
        .frame(height: 35)
        .foregroundStyle(.white)
        .padding(.horizontal, 15)
        .background{
            Capsule()
                .fill(color.gradient)
        }
    }
    
}
