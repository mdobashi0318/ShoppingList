//
//  AddItemViewModel.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/19.
//

import Foundation


class AddItemViewModel: ObservableObject {
    
    @Published var itemId: String?
    
    @Published var name: String = ""
    
    @Published var price: String = ""
    
    @Published var errorFlag = false
    
    var errorMessage = ""
    
    init(itemId: String? = nil) {
        if let itemId {
            self.itemId = itemId
            fetch()
        }
    }
    
    func validation() -> Bool {
        if name.isEmpty {
            errorMessage = "商品名が入力されていません"
            errorFlag = true
            return false
        } else if price.isEmpty {
            errorMessage = "金額が入力されていません"
            errorFlag = true
            return false
        }
        
        errorFlag = false
        return true
    }
    
    func fetch() {
        do {
            guard let itemId else {
                throw ModelError()
            }
            let model = try Item.fetch(id: itemId)
            name = model.name
            price = String(model.price)
        } catch {
            errorMessage = "見つかりません"
        }
    }
    
    func add() { }
}
