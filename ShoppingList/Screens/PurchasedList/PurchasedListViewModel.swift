//
//  PurchasedListViewModel.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/12/17.
//

import Foundation

class PurchasedListViewModel: ShoppingListViewModel {
    
    func total() -> Int {
        var totalPrice: Int = 0
        self.model.forEach {
            totalPrice += (fetchItem(itemId: $0.itemId)?.price ?? 0) * $0.count
        }
        return totalPrice
    }   
}
