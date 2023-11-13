//
//  SigninPageView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2023/11/13.
//

import SwiftUI

struct SigninPageView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var loginName: String = ""
    @State private var loginPass: String = ""
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20){
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .tint(.red)
            })
            .hSpacing(.leading)
            
            Text("新規登録")
                .font(.largeTitle)
            
            TextField("Login Name", text: $loginName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            
            TextField("Login Pass", text: $loginPass)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            
            Button("新規登録") {
                //ログイン処理
                
            }
            .frame(width: 200, height: 45)
            .foregroundColor(Color.white)
            .background(loginName != "" && loginPass != "" ? Color.green: Color.gray)
            .cornerRadius(10, antialiased: true)
            .disabled(loginName == "" && loginPass == "")
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 30, trailing: 0))
            
            
            
        }
        
        
    }
}
#Preview {
    SigninPageView()
}
