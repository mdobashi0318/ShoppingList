//
//  ShoppingList.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/10/28.
//

import SwiftUI

struct ShoppingList: View {
    
    @StateObject private var viewModel = ShoppingListViewModel(purchaseStatus: .unPurchased)
    
    @State private var addPageSheet = false

    var body: some View {
        NavigationStack {
            list
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        AddButton {
                            addPageSheet.toggle()
                        }
                    }
                }
                .sheet(isPresented: $addPageSheet) {
                    AddShoppingScreen()
                }
                .task(id: addPageSheet) {
                    if !addPageSheet {
                        viewModel.fetchModels()
                    }
                }
                .navigationTitle(R.string.naviTitle.listOfPlannedPurchases())
                .navigationDestination(for: String.self) { shoppingId in
                    ShoppingDetailScreen(viewModel: ShoppingDetailViewModel(id: shoppingId))
                }
                .onAppear {
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
                ForEach($viewModel.model) { shopping in
                    NavigationLink(value: shopping.id) {
                        ShoppingRow(
                            name: viewModel.fetchItem(itemId: shopping.itemId.wrappedValue)?.name ?? R.string.label.notFound(),
                            count: shopping.count.wrappedValue,
                            totalPrice: viewModel.totalPrice(shopping.wrappedValue)
                        )
                        .swipeActions {
                            Button(R.string.button.markAsPurchased()) {
                                viewModel.updatePurchaseStatus(shoppingId: shopping.id,
                                                               itemId: shopping.itemId.wrappedValue
                                )
                                viewModel.model.removeAll(where: { $0.id == shopping.id })
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ShoppingList()
}
