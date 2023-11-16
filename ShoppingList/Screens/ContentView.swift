//
//  ContentView.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/10/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            ShoppingList()
            .navigationTitle("ShoppingList")
            
        }
    }
}

#Preview {
    ContentView()
}
