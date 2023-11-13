//
//  MyPageView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2023/09/13.
//

import SwiftUI

struct MyPageView: View {
    
    @State private var loginOk: Bool = false
    
    var body: some View {
        if(!loginOk) {
            LoginPageView()
        }else {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
