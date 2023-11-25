//
//  EllipsisButton.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/23.
//

import SwiftUI

struct EllipsisButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: {
             action()
         }) {
             Image(systemName: "ellipsis")
         }
    }
}

#Preview {
    EllipsisButton(action: { })
}
