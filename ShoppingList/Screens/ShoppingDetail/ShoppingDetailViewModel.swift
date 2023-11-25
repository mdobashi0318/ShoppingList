//
//  ShoppingDetailViewModel.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/11.
//

import Foundation

class ShoppingDetailViewModel: ObservableObject {
    
    @Published var shopping = Shopping()
    
    @Published var item = Item()
    
    @Published var purchased = false
    
    var id = ""
  
    var errorMessage = ""
    
    
    init(id: String) {
        self.id = id
        fetchShopping()
        fetchItem()
    }
    
    private func fetchShopping() {
        do {
            shopping = try Shopping.fetch(id: id)
            purchased = shopping.purchased == PurchaseStatus.purchased.rawValue ? true : false
        } catch {
            errorMessage = "見つかりません"
        }
    }

    
    private func fetchItem() {
        do {
            item = try Item.fetch(id: shopping.itemId)
        } catch {
            errorMessage = "見つかりません"
        }
    }
    
    
    func updatePurchaseStatus() {
        try? Shopping.updatePurchaseStatus(id: id, status: purchased)
    }
    
    
    func delete() {
        do {
            try Shopping.delete(shopping)
            shopping = Shopping()
        } catch {
            errorMessage = "見つかりません"
        }
    }
    
    
    
}
