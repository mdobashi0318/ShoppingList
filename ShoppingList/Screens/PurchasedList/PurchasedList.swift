//
//  PurchasedList.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/12/17.
//

import SwiftUI

struct PurchasedList: View {
    
    @StateObject var viewModel = PurchasedListViewModel(purchaseStatus: .purchased)
    
    private let tab = Tabs.purchasedList
    
    var body: some View {
        NavigationStack {
            list
                .navigationTitle(tab.rawValue)
        }
    }
    
    @ViewBuilder
    var list: some View {
        if viewModel.model.isEmpty {
            Text("リストにアイテムがありません")
        } else {
            List {
                Section {
                    ForEach($viewModel.model) { shopping in
                        NavigationLink(value: shopping.id) {
                            ShoppingRow(
                                name: viewModel.fetchItem(itemId: shopping.itemId.wrappedValue)?.name ?? "見つかりません",
                                count: shopping.count.wrappedValue,
                                totalPrice: viewModel.totalPrice(shopping.wrappedValue),
                                purchaseStatus: shopping.purchased.wrappedValue,
                                toggleValue: shopping.purchased.wrappedValue == PurchaseStatus.purchased.rawValue,
                                toggleAction: {
                                    viewModel.updatePurchaseStatus(shoppingId: shopping.id, purchased: $0)
                                }
                            )
                        }
                    }
                }
            header: {
                Text("購入金額: ¥\(viewModel.total())")
            }
            }
            .navigationDestination(for: String.self) { shoppingId in
                ShoppingDetailScreen(viewModel: ShoppingDetailViewModel(id: shoppingId))
            }
            .onDisappear {
                viewModel.fetchModels()
            }
        }
    }
}

#Preview {
    PurchasedList()
}
