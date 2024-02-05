//
//  ShoppingDetailView.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2024/02/06.
//

import SwiftUI

struct ShoppingDetailView: View {
    
    let name: String
    
    let price: Int
    
    let itemCount: Int
    
    @Binding var toggleValue: Bool
    
    let toggleAction: (Bool) -> Void
    
    var body: some View {
        Form {
            Section {
                ItemDetailView(name: name,
                               price: price
                )
                HStack {
                    Text(R.string.label.quantity())
                    Spacer()
                    Text("\(itemCount)\(R.string.label.pieces())")
                }
            } header: {
                Text(R.string.label.productInformation())
            }
            
            HStack {
                Text(R.string.label.totalAmount())
                Spacer()
                Text("¥\(price * itemCount)")
            }
            Toggle(isOn: $toggleValue, label: {
                Text(R.string.label.alreadyBought())
            })
            .onChange(of: toggleValue) {
                toggleAction($0)
            }
            
        }
    }
}

