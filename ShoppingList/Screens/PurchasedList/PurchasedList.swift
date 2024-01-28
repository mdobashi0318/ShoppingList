//
//  PurchasedList.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/12/17.
//

import SwiftUI

struct PurchasedList: View {
    
    @StateObject private var viewModel = PurchasedListViewModel()
    
    var body: some View {
        NavigationStack {
            list
                .navigationTitle(R.string.naviTitle.purchasedList())
                .navigationDestination(for: String.self) { shoppingId in
                    ShoppingDetailScreen(viewModel: ShoppingDetailViewModel(id: shoppingId))
                }
                .onDisappear {
                    viewModel.fetch()
                }
        }
    }
    
    @ViewBuilder
    private var list: some View {
        if $viewModel.model.isEmpty {
            Text(R.string.label.noList())
        } else {
            List {
                Section {
                    ForEach($viewModel.model) { item in
                        NavigationLink(value: item.id) {
                            ShoppingRow(
                                name: item.itemName.wrappedValue,
                                count: item.count.wrappedValue,
                                totalPrice: item.price.wrappedValue * item.count.wrappedValue,
                                purchaseStatus: PurchaseStatus.purchased.rawValue,
                                toggleValue: true,
                                toggleAction: {
                                    viewModel.updatePurchaseStatus(shoppingId: item.shoppingId.wrappedValue,
                                                                   purchased: $0,
                                                                   itemId: item.itemId.wrappedValue)
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
