//
//  StackCardView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2024/01/09.
//

import SwiftUI
import Kingfisher

struct StackCardView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    var food: Post
    
    
    
    //ジェスチャー
    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false
    
    @State var endSwipe: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            let index = CGFloat(viewModel.getIndex(food: food))
            
            let topOffset = (index <= 2 ? index : 2) * 5
            
            ZStack {
                
                KFImage(URL(string: food.imageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: abs(size.width / 1.5 - topOffset), height: abs(size.width / 1.5))
                    .cornerRadius(15)
                    .offset(y: -topOffset)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
           
        }
        .offset(x: offset)
        .rotationEffect(.init(degrees: getRotation(angle: 8)))
        .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
        .gesture(
            DragGesture()
                .updating($isDragging, body: { value, out, _ in
                    out = true
                })
                .onChanged({ value in
                    let translation = value.translation.width
                    offset = (isDragging ? translation: .zero)
                })
                //離したとき？
                .onEnded({ value in
                    let width = getRect().width - 50
                    let translation = value.translation.width
                    
                    let checkingStatus = (translation > 0 ? translation: -translation)
                    
                    withAnimation{
                        if checkingStatus > (width / 2) {

                            
                            //foodを消す
                            offset = (translation > 0 ? width : -width) * 2
                            endSwipeAction(rightSwipe: translation > 0)
                            
                            if translation > 0{
                                print("right")
                            } else {
                                print("left")
                            }
                        }
                        else {
                            //リセット
                            offset = .zero
                        }
                    }
                })
        )
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"), object: nil)) { data in
                guard let info = data.userInfo else{
                    return
                }
            
                let id = info["id"] as? String ?? ""
                let rightSwipe = info["rightSwipe"] as? Bool ?? false
            let width = getRect().width - 50
            
            if food.id == id {
                withAnimation{
                    //foodを消す
                    offset = (rightSwipe ? width : -width) * 2
                    endSwipeAction(rightSwipe: rightSwipe)
                    
                    if rightSwipe{
                        print("right")
                    } else {
                        print("left")
                    }
                }
            }
        }
    }
    //カードをスライドするときに角度を付ける
    func getRotation(angle: Double) -> Double {
        let rotation = (offset / (getRect().width - 50)) * angle
        
        return rotation
    }
    
    func endSwipeAction(rightSwipe: Bool) {
        withAnimation(.none){endSwipe = true}
        
        //何度も連続してできないように時間をすこしあける
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            if let firstPost = viewModel.displaying_posts?.first{
                let _ = withAnimation{
                    if(rightSwipe){
                        viewModel.addItem(food: firstPost)
                    }
                    viewModel.displaying_posts?.removeFirst()
                }
            }
        }
    }
    
}

#Preview {
    HomeView()
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

