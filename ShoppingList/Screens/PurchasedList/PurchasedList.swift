//
//  PurchasedList.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/12/17.
//

import SwiftUI

struct PurchasedList: View {
    
    @StateObject private var viewModel = PurchasedListViewModel(purchaseStatus: .purchased)
    
    var body: some View {
        NavigationStack {
            list
                .navigationTitle(R.string.naviTitle.purchasedList())
                .navigationDestination(for: String.self) { shoppingId in
                    ShoppingDetailScreen(viewModel: ShoppingDetailViewModel(id: shoppingId))
                }
                .onDisappear {
                    viewModel.fetchModels()
                }
        }
    }
    
    @ViewBuilder
    private var list: some View {
        if viewModel.model.isEmpty {
            Text(R.string.label.noList())
        } else {
            List {
                Section {
                    ForEach($viewModel.model) { shopping in
                        NavigationLink(value: shopping.id) {
                            ShoppingRow(
                                name: viewModel.fetchItem(itemId: shopping.itemId.wrappedValue)?.name ?? R.string.label.notFound(),
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
                } header: {
                    Text("\(R.string.label.purchasePrice()): ¥\(viewModel.total())")
                }
            }
        }
    }
}

#Preview {
    PurchasedList()
}
