//
//  LoginView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/04.
//

import SwiftUI

struct LoginView: View {

    @StateObject var viewModel = LoginViewModel()
    
    @State var passHidden = true
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                Text("MyCooking")
                    .frame(width: 220, height: 100)
                    .font(.largeTitle)
                
                //textField
                VStack {
                    TextField("メールアドレス", text: $viewModel.email)
                        .frame(width: 320,height: 35)
                        //自動大文字の制御
                        .autocapitalization(.none)
                        .modifier(IGTextFieldModifire())
                        .padding(.bottom, 3)
                    
                    ZStack{
                        HStack{
                            if passHidden {
                                SecureField("パスワード", text: $viewModel.password)
                                    .frame(width: 320,height: 35)
                                    .autocapitalization(.none)
                                    .modifier(IGTextFieldModifire())
                                    .offset(x: 17, y:0)
                                
                            }else{
                                TextField("パスワード", text: $viewModel.password)
                                    .frame(width: 320,height: 35)
                                    .autocapitalization(.none)
                                    .modifier(IGTextFieldModifire())
                                    .offset(x: 17, y:0)
                                    .padding(.vertical, 1.7)
                                
                            }
                            Button(action: {self.passHidden.toggle() }) {
                                Image(systemName: self.passHidden ? "eye.slash.fill": "eye.fill")
                                    .foregroundColor((self.passHidden == true) ? Color.secondary : Color.gray)
                            }.offset(x: -50, y:0)
                        }
                    }
                    
                }
                
                
                Button {
                    print("パスワードを忘れた！")
                }label: {
                    Text("パスワードを忘れた場合")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 20)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Button {
                    Task { try await viewModel.signIn() }
                }label: {
                    Text("ログイン")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 44)
                        .background(Color(.systemBlue))
                        .cornerRadius(8)
                }
                .padding(.vertical)
                
                HStack {
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                    
                    
                    Text("または")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                    
                }
                .foregroundColor(.gray)
                
                NavigationLink{
                    AddEmailView()
                        .navigationBarBackButtonHidden(true)
                } label:{
                    HStack(spacing: 3){
                        Text("アカウントを持っていない場合")
                            .foregroundStyle(.gray)
                        
                        Text("登録はこちら")
                            .fontWeight(.semibold)
                        
                    }
                    .font(.footnote)
                    
                }
                
                Spacer()
                
                
            }
        }
    }
}

#Preview {
    LoginView()
}
