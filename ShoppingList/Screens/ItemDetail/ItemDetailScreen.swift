//
//  ItemDetailScreen.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/20.
//

import SwiftUI

struct ItemDetailScreen: View {
    
    @StateObject var viewModel: ItemDetailViewModel
    
    var body: some View {
        Form {
            ItemDetailView(name: viewModel.model.name,
                           price: viewModel.model.price
            )
        }
        .navigationTitle("アイテム追加")
    }
}

#Preview {
    ItemDetailScreen(viewModel: ItemDetailViewModel(itemId: ""))
}
