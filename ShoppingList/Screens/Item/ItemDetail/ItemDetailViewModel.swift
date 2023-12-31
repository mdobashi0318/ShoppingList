//
//  ItemDetailViewModel.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/20.
//

import Foundation


class ItemDetailViewModel: ObservableObject {
    
    var itemId: String
    
    @Published var model = Item()
    
    @Published var errorFlag = false
    
    var errorMessage = ""
    
    init(itemId: String) {
        self.itemId = itemId
        fetch()
    }
    
    func fetch() {
        do {
            model = try Item.fetch(id: itemId)
        } catch {
            errorMessage = R.string.label.notFound()
            errorFlag = true
        }
    }
    
    func delete() { }
    
    
}
