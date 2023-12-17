//
//  ContentView.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/10/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView() {
            ShoppingList()
            .tabItem { Label("List", systemImage: "cart") }
            
            ItemListScreen()
                .tabItem { Label("Item", systemImage: "bag.fill") }
            
            PurchasedList()
            .tabItem { Label("List", systemImage: "chineseyuanrenminbisign.circle") }
        }
    }
}

#Preview {
    ContentView()
}
