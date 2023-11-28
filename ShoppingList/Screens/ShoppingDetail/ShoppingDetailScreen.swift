//
//  ShoppingDetailScreen.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/11.
//

import SwiftUI

struct ShoppingDetailScreen: View {
    
    @StateObject var viewModel: ShoppingDetailViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State var isActionSheet = false
    
    @State var isEditScreen = false
    
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
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                EllipsisButton(action: { isActionSheet.toggle() })
            }
        }
        .confirmationDialog("どうしますか？", isPresented: $isActionSheet) {
            Button("編集") {
                isEditScreen.toggle()
            }
            Button("削除", role: .destructive) {
                viewModel.delete()
                self.dismiss()
            }
        }
        .sheet(isPresented: $isEditScreen) {
            AddShoppingScreen(viewModel: AddShoppingViewModel(shoppingId: viewModel.id))
                .onDisappear {
                    viewModel.fetchShopping()
                }
        }
    }
}

#Preview {
    ShoppingDetailScreen(viewModel: ShoppingDetailViewModel(id: ""))
}
