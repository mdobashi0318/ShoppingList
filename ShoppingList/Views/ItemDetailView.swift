//
//  ItemDetailView.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/20.
//

import SwiftUI

struct ItemDetailView: View {
    
    let name: String
    
    let price: Int
    
    
    var body: some View {
        HStack {
            Text("商品")
            Spacer()
            Text(name)
        }
        
        HStack {
            Text("金額")
            Spacer()
            Text("¥\(price)")
        }
        
    }
}

#Preview {
    ItemDetailView(name: "name", price: 1000)
}
