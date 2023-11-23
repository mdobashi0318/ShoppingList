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
            TextField("商品名を入力してください", text: $name)
            TextField("金額を入力してください", text: $price)
                .keyboardType(.numberPad)
    }
}

#Preview {
    ItemAddFormView(name: .constant("商品名"), price: .constant("100"))
}
