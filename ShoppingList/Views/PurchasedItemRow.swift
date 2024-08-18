//
//  PurchasedItemRow.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2024/01/29.
//

import SwiftUI

struct PurchasedItemRow: View {
    let name: String
    
    let count: Int
    
    let totalPrice: Int
        
    let purchaseDate: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(name)
                    Text("\(count) \(R.string.label.pieces())")
                }
                Text("¥\(totalPrice)")
                Text("\(R.string.label.purchaseDate())\(purchaseDate)")
            }
        }
    }
}

//#Preview {
//    PurchasedItemRow()
//}
