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
    
    private let tab: Tabs = .shoppingList

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
                .navigationTitle(tab.rawValue)
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
            Text("リストにアイテムがありません")
        } else {
            List {
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
        }
    }
}

#Preview {
    ShoppingList()
}