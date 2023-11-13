//
//  PopularPageView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2023/09/13.
//

import SwiftUI

struct PopularPageView: View {
    
    let textColor: Color = .black
    
    var body: some View {
        NavigationView{
            VStack {
                HStack{
                    Button(action: a){
                        Text("朝食")
                            .frame(width: 110, height: 50)
                            .background(.red)
                            .cornerRadius(10)
                            .foregroundColor(textColor)
                    }
                    Button(action: a){
                        Text("朝食")
                            .frame(width: 110, height: 50)
                            .background(.blue)
                            .cornerRadius(10)
                            .foregroundColor(textColor)
                    }
                    Button(action: a){
                        Text("朝食")
                            .frame(width: 110, height: 50)
                            .background(.green)
                            .cornerRadius(10)
                            .foregroundColor(textColor)
                    }
                }
                HStack{
                    Button(action: a){
                        Text("朝食")
                            .frame(width: 110, height: 50)
                            .background(.yellow)
                            .cornerRadius(10)
                            .foregroundColor(textColor)
                    }
                    Button(action: a){
                        Text("朝食")
                            .frame(width: 110, height: 50)
                            .background(.pink)
                            .cornerRadius(10)
                            .foregroundColor(textColor)
                    }
                    Button(action: a){
                        Text("朝食")
                            .frame(width: 110, height: 50)
                            .background(.purple)
                            .cornerRadius(10)
                            .foregroundColor(textColor)
                    }
                }
                HStack{
                    Button(action: a){
                        Text("朝食")
                            .frame(width: 110, height: 50)
                            .background(.gray)
                            .cornerRadius(10)
                            .foregroundColor(textColor)
                    }
                    Button(action: a){
                        Text("朝食")
                            .frame(width: 110, height: 50)
                            .background(.brown)
                            .cornerRadius(10)
                            .foregroundColor(textColor)
                    }
                    Button(action: a){
                        Text("朝食")
                            .frame(width: 110, height: 50)
                            .background(.mint)
                            .cornerRadius(10)
                            .foregroundColor(textColor)
                    }
                }
                
            }
            .navigationTitle("人気のキーワード")
        }
        
    }
    func a(){
        
    }
}

struct PopularPageView_Previews: PreviewProvider {
    static var previews: some View {
        PopularPageView()
    }
}
