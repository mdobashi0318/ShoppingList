//
//  PurchasedListViewModel.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/12/17.
//

import Foundation

class PurchasedListViewModel: ObservableObject {
    
    @Published var model: [PurchasedItem] = []
    
    @Published var alertFlag = false
    
    private(set) var alertType: AlertType = .success
    
    private(set) var alertMessage = ""
    
    func fetch() {
        do {
            model = try PurchasedItem.allFetch()
        } catch {
            alertMessage = R.string.label.notFound()
        }
    }
    
    func total() -> Int {
        var totalPrice: Int = 0
        self.model.forEach {
            totalPrice += $0.price * $0.count
        }
        return totalPrice
    }   
    
    
    /// ステータスを未購入に変更し、購入済リストから削除する
    func updatePurchaseStatus(shoppingId: String, itemId: String) {
        try? Shopping.updatePurchaseStatus(id: shoppingId, status: false)
        try? PurchasedItem.deleteItem(shoppingId: shoppingId)
    }
    
    
    func setAlert(type: AlertType, message: String) {
        alertType = type
        alertMessage = message
        alertFlag = true
    }
}
