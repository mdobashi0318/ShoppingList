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
                    PurchasedDetailScreen(viewModel: PurchasedDetailViewModel(id: shoppingId))
                }
                .onAppear {
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
                            PurchasedItemRow(
                                name: item.itemName.wrappedValue,
                                count: item.count.wrappedValue,
                                totalPrice: item.price.wrappedValue * item.count.wrappedValue,
                                purchaseDate: item.purchaseDate.wrappedValue
                            )
                        }
                        .swipeActions {
                            Button(R.string.button.returnToUnpurchased()) {
                                viewModel.updatePurchaseStatus(shoppingId: item.shoppingId.wrappedValue,
                                                               itemId: item.itemId.wrappedValue)
                                withAnimation {
                                    viewModel.model.removeAll(where: { $0.id == item.id })
                                }
                                
                            }
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
