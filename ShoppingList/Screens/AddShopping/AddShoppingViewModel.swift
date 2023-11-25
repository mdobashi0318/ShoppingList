//
//  AddShoppingViewModel.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/10/30.
//

import Foundation
import Combine

class AddShoppingViewModel: ObservableObject {
    
    var shoppingId: String?
    
    private(set) var mode: Mode = .add
    
    @Published var name: String = ""
    
    @Published var price: String = ""
    
    @Published var count: String = ""
    
    @Published var errorFlag = false
    
    var errorMessage = ""
    
    @Published var model: [Item] = []
    
    @Published var select: Item?
    
    @Published var itemId: String = ""
    
    @Published var inputItem = false
    
    init(shoppingId: String? = nil) {
        fetchItems()
        if let shoppingId {
            mode = .update
            self.shoppingId = shoppingId
            guard let shopping = try? Shopping.fetch(id: shoppingId),
                  let item = try? Item.fetch(id: shopping.itemId) else {
                return
            }
            name = item.name
            price = String(describing: item.price)
            count = String(describing: shopping.count)   
        }
    }
    
    func add() {
        do {
            if !inputItem {
                itemId = try Item.addItem(Item(name: name, price: price))
            }
            
            try Shopping.add(Shopping(itemId: itemId, count: count, purchased: PurchaseStatus.unPurchased.rawValue))
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    func validation() -> Bool {
        print(itemId)
        print(inputItem)
        
        if inputItem {
            if itemId.isEmpty {
                errorMessage = "商品が選択されていません"
                errorFlag = true
                return false
            } else if count.isEmpty {
                errorMessage = "個数が入力されていません"
                errorFlag = true
                return false
            }

        } else {
            if name.isEmpty {
                errorMessage = "商品名が入力されていません"
                errorFlag = true
                return false
            } else if price.isEmpty {
                errorMessage = "金額が入力されていません"
                errorFlag = true
                return false
                
            } else if count.isEmpty {
                errorMessage = "個数が入力されていません"
                errorFlag = true
                return false
            }
        }
        
        
        
   
        errorFlag = false
        return true
    }
    
    
    
    private func fetchItems() {
        do {
            model.append(Item())
             try Item.allFetch().forEach {
                model.append($0)
            }
        } catch {
            errorMessage = "見つかりません"
        }
    }
    
    enum Mode {
        case add, update
    }
    
}

