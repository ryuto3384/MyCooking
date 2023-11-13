//
//  ViewExtensions.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2023/11/13.
//

import SwiftUI

//Custom View Extensions
//ここを変更した
//test1がここを変更した
//スペーサーの代わりによく使用する
//extension-> 既存のクラスや構造体に対してプロパティやメソッドを追加できる
extension View {
    //通常クロージャが返す値は1つのView。そこでViewBuilderを使うと、複数のViewを1つのViewとみなして、複数のViewを返すことができる
    @ViewBuilder
    func hSpacing(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity , alignment: alignment)//aligment:場所や位置
    }
    @ViewBuilder
    func vSpacing(_ alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity , alignment: alignment)//aligment:場所や位置
    }
    
    func isSameDate (_ date1: Date, _ date2: Date ) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
}
