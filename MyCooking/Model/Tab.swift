//
//  Tab.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2023/11/07.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case list = "list.clipboard"
    case film = "film.stack"
    case home = "rectangle.on.rectangle.angled"
    case post = "cooktop"
    case mine = "person"
    
    var title: String {
        switch self {
        case .list:
            return "List"
        case .film:
            return "Film"
        case .home:
            return "Home"
        case .post:
            return "Post"
        case .mine:
            return "mine"
        }
    }
}

//tabanimation
struct AnimatedTab: Identifiable {
    var id: UUID = .init()
    var tab: Tab
    var isAnimating: Bool?
}
