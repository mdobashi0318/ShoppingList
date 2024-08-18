//
//  ShoppingListViewModel.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/10/28.
//

import Foundation

class ShoppingListViewModel: ObservableObject {
    
    @Published var model: [Shopping] = []
    
    @Published var items: [Item] = []
    
    var errorMessage = ""
    
    var purchaseStatus: PurchaseStatus
    
    
    init(purchaseStatus: PurchaseStatus) {
        self.purchaseStatus = purchaseStatus
        fetchModels()
    }
    
    func fetchModels() {
        fetchShopping()
        fetchItems()
    }
    
    private func fetchShopping() {
        do {
            model = try Shopping.fetchList(purchaseStatus: purchaseStatus)
        } catch {
            errorMessage = R.string.label.notFound()
        }
    }

    
    private func fetchItems() {
        do {
            items = try Item.allFetch()
        } catch {
            errorMessage = R.string.label.notFound()
        }
    }
    
    
    func fetchItem(itemId: String) -> Item? {
        items.first(where: { $0.id == itemId } )
    }
    
    
    func totalPrice(_ shopping: Shopping) -> Int {
        (fetchItem(itemId: shopping.itemId)?.price ?? 0) * shopping.count
    }
    
    /// ステータスを購入済に変更し、購入済リストに追加する
    func updatePurchaseStatus(shoppingId: String, itemId: String) {
        try? Shopping.updatePurchaseStatus(id: shoppingId, status: true)
        try? PurchasedItem.addItem(shoppingId: shoppingId, itemId: itemId)
        
    }
    
}
