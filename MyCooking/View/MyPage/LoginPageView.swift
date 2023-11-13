//
//  LoginPageView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2023/11/13.
//

import SwiftUI

struct LoginPageView: View {
    
    @State private var loginName: String = ""
    @State private var loginPass: String = ""
    
    var body: some View {
        VStack(alignment: .center){
                TextField("Login Name", text: $loginName)
                    .frame(width: 230, height: 70)
                    .cornerRadius(5)
                    .background(Color.red)
            
        }
        
    }
}

#Preview {
    LoginPageView()
}
