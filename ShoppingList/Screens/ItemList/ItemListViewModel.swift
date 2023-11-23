//
//  ItemListViewModel.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/18.
//

import Foundation

class ItemListViewModel: ObservableObject {
    
    @Published var model: [Item] = []
    
    init() {
        fetchItems()
    }
    
    
    func fetchItems() {
        model = try! Item.allFetch()
    }
    
}
