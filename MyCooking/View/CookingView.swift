//
//  CookingView.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2023/09/13.
//

import SwiftUI

struct CookingView: View {
    
    @State private var activeTab: Tab = .home
    
    @State private var allTabs: [AnimatedTab] = Tab.allCases.compactMap { tab -> AnimatedTab? in
        return .init(tab: tab)
    }
    
    var body: some View {
        VStack {
            TabView(selection: $activeTab) {
                FoodListView()
                    .setUpTab(.list)
                FakeTickTokView()
                    .setUpTab(.film)
                FakeTinderView()
                    .setUpTab(.home)
                MyPostView()
                    .setUpTab(.post)
                MyPageView()
                    .setUpTab(.mine)
                    
                
            }
            Spacer()
            if #available(iOS 17.0, *) {
                CustomTabBar()
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
    
    @available(iOS 17.0, *)
    @ViewBuilder
    func CustomTabBar() -> some View {
        HStack(spacing: 0) {
            ForEach($allTabs) { $animatedTab in
                let tab = animatedTab.tab
                
                VStack(spacing: 4) {
                    Image(systemName: tab.rawValue)
                        .font(.title)
                        //シンボルアニメーション
                        .symbolEffect(.bounce.down.byLayer,  value: animatedTab.isAnimating)
                    
                    Text(tab.title)
                        .font(.caption2)
                        .textScale(.secondary)
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(activeTab == tab ? Color.primary : Color.gray.opacity(0.8))
                .padding(.top, 10)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.bouncy, completionCriteria: .logicallyComplete, {
                        activeTab = tab
                        animatedTab.isAnimating = true
                    }, completion: {
                        var trasnaction = Transaction()
                        trasnaction.disablesAnimations = true
                        withTransaction(trasnaction) {
                            animatedTab.isAnimating = nil
                        }
                    })
                }
            }
        }
        .background(.bar)
    }
}

#Preview {
    CookingView()
}

extension View {
    @ViewBuilder
    func setUpTab(_ tab: Tab) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .tag(tab)
            .toolbar(.hidden, for: .tabBar)
    }
}
