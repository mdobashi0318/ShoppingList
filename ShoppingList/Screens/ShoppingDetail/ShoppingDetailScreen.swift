//
//  ShoppingDetailScreen.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/11.
//

import SwiftUI

struct ShoppingDetailScreen: View {
    
    @StateObject var viewModel: ShoppingDetailViewModel
    
    
    
    var body: some View {
        Form {
            Section {
                ItemDetailView(name: viewModel.item.name,
                               price: viewModel.item.price
                )
                
                
                HStack {
                    Text("個数")
                    Spacer()
                    Text("\(viewModel.shopping.count)個")
                }
            } header: {
                Text("商品情報")
            }
            
            HStack {
                Text("合計金額")
                Spacer()
                Text("¥\(viewModel.item.price * viewModel.shopping.count)")
            }
            Toggle("購入済", isOn: $viewModel.purchased)
        }
        .task(id: viewModel.purchased) {
            viewModel.updatePurchaseStatus()
        }
        .navigationTitle("購入内容")
        
    }
}

#Preview {
    ShoppingDetailScreen(viewModel: ShoppingDetailViewModel(id: ""))
}
