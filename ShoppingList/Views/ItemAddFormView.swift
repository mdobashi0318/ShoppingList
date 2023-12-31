//
//  AddItemFormView.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/19.
//

import SwiftUI

struct ItemAddFormView: View {
    
    @Binding var name: String
    
    @Binding var price: String
    
    var body: some View {
        TextField(R.string.label.pleaseEnterAProductName(), text: $name)
            TextField(R.string.label.pleaseEnterAnAmount(), text: $price)
                .keyboardType(.numberPad)
    }
}

#Preview {
    ItemAddFormView(name: .constant("商品名"), price: .constant("100"))
}
