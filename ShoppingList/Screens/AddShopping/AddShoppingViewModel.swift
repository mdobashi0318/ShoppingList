//
//  AddShoppingViewModel.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/10/30.
//

import Foundation

@MainActor
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
    
    init(mode: Mode = .add, shoppingId: String? = nil) {
        self.mode = mode
        fetchItems()
        if mode == .update {
            fetchShopping(shoppingId)
        }
    }
    
    private func fetchShopping(_ shoppingId: String?) {
        guard let shoppingId else {
            return
        }
        
        do {
            self.shoppingId = shoppingId
            let shopping = try Shopping.fetch(id: shoppingId)
            let item = try Item.fetch(id: shopping.itemId)
            name = item.name
            price = String(describing: item.price)
            count = String(describing: shopping.count)
            itemId = shopping.itemId
        } catch {
            Task {
                /// この時点でシートが表示されてないためか、アラートが表示されないため表示フラグを変更するタイミングを遅らせる
                try await Task.sleep(until: .now + .seconds(0.1))
                errorMessage = "見つかりません"
                errorFlag = true
            }
        }
    }
    
    func add() {
        do {
            if !inputItem {
                itemId = try Item.addItem(Item(name: name, price: price))
            }
            
            try Shopping.add(Shopping(itemId: itemId, count: count, purchased: PurchaseStatus.unPurchased.rawValue))
        } catch {
            errorMessage = "追加に失敗しました"
            errorFlag = true
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
        return true
    }
    
    
    
    func update() {
        guard let shoppingId else {
            return
        }
        
        do {
            try Shopping.update(Shopping(id: shoppingId, count: Int(count) ?? 0))
        } catch {
            errorMessage = "更新に失敗しました"
            errorFlag = true
        }
    }
    
    private func fetchItems() {
        do {
            model.append(Item())
             try Item.allFetch().forEach {
                model.append($0)
            }
        } catch {
            errorMessage = "見つかりません"
            errorFlag = true
        }
    }
    
    enum Mode {
        case add, update
    }
    
}

