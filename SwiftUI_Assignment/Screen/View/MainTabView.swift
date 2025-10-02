//
//  TabView.swift
//  SwiftUI_Assignment
//
//  Created by Ankit on 02/10/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                PostViewScreen()
            }
            .tabItem {
                Label("All Posts", systemImage: "doc.text")
            }

            NavigationView {
                FavoritesView()
            }
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
        }
    }
}
