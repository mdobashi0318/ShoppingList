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
        
    var purchaseStatus: String
    
    @State var toggleValue: Bool
    
    let toggleAction: (Bool) -> Void
    
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
            Spacer()
            Toggle(isOn: $toggleValue, label: {
                Text("")
            })
            .onChange(of: toggleValue) {
                toggleAction($0)
            }
            .frame(width: 50)
        }
    }
}

//#Preview {
//    PurchasedItemRow()
//}
