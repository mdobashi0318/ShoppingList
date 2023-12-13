//
//  ContentView.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var title = "ShoppingList"
    
    var body: some View {
        TabView() {
            ShoppingList(viewModel: ShoppingListViewModel(purchaseStatus: .unPurchased),
                         tab: Tabs.shoppingList)
            .tabItem { Label("List", systemImage: "cart") }
            
            ItemListScreen(tab: Tabs.itemList)
                .tabItem { Label("Item", systemImage: "bag.fill") }
            
            ShoppingList(viewModel: ShoppingListViewModel(purchaseStatus: .purchased),
                         tab: Tabs.purchasedList)
            .tabItem { Label("List", systemImage: "chineseyuanrenminbisign.circle") }
        }
    }
}

#Preview {
    ContentView()
}
