//
//  ShoppingRow.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/29.
//

import SwiftUI

struct ShoppingRow: View {
    
    let name: String
    
    let count: Int
    
    let totalPrice: Int
        
    var purchaseStatus: String
    
    @State var toggleValue: Bool
    
    let toggleAction: (Bool) -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(name)
                    Text("\(count) \(R.string.label.pieces())")
                }
                Text("¥\(totalPrice)")
            }
            
            Toggle(isOn: $toggleValue, label: {
                Text("")
            })
            .onChange(of: toggleValue) {
                toggleAction($0)
            }
        }
    }
}

