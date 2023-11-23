//
//  ContentView.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection = 0
    
    
    @State var title = "ShoppingList"
    
    var body: some View {
        
            TabView(selection: $selection) {
                ShoppingList()
                    .tabItem { Label("List", systemImage: "cart.fill") }
                    .tag(0)
                
                ItemListScreen()
                    .tabItem { Label("Item", systemImage: "bag.fill") }
                    .tag(1)
            }
            .task(id: selection) {
                if selection == 0 {
                    title = "ShoppingList"
                } else {
                    title = "ItemList"
                }
            }
            
            
            
        
    }
}

#Preview {
    ContentView()
}
