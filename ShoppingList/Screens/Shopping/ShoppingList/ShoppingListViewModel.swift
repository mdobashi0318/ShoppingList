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
    
    
    init() {
        fetchModels()
    }
    
    func fetchModels() {
        fetchAll()
        fetchItems()
    }
    
    private func fetchAll() {
        do {
            model = try Shopping.allFetch()
        } catch {
            errorMessage = "見つかりません"
        }
    }

    
    private func fetchItems() {
        do {
            items = try Item.allFetch()
        } catch {
            errorMessage = "見つかりません"
        }
    }
    
    
    func fetchItem(itemId: String) -> Item? {
        items.first(where: { $0.id == itemId } )
    }
    
    
    func totalPrice(_ shopping: Shopping) -> Int {
        (fetchItem(itemId: shopping.itemId)?.price ?? 0) * shopping.count
    }
    
    func updatePurchaseStatus(shoppingId: String, purchased: Bool) {
        try? Shopping.updatePurchaseStatus(id: shoppingId, status: purchased)
    }
    
}
