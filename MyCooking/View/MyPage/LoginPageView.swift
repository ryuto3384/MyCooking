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
    @State private var signinSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            Text("ログイン")
                .font(.largeTitle)
            
            TextField("Login Name", text: $loginName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            
            TextField("Login Pass", text: $loginPass)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            
            Button("ログイン") {
                //ログイン処理
                
            }
            .frame(width: 200, height: 45)
            .foregroundColor(Color.white)
            .background(loginName != "" && loginPass != "" ? Color.green: Color.gray)
            .cornerRadius(10, antialiased: true)
            .disabled(loginName == "" && loginPass == "")
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))
            
            Text("新規登録へ")
                .font(.caption)
                .foregroundColor(.gray)
                .onTapGesture {
                    signinSheet.toggle()
                }
                .sheet(isPresented: $signinSheet) {
                    SigninPageView()
                        .presentationDetents([.height(600)])
                        .presentationCornerRadius(30)
                }
            
        }
        
    }
}

#Preview {
    LoginPageView()
}
