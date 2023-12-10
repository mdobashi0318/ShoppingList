//
//  AddShoppingViewModel.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/10/30.
//

import Foundation

@MainActor
class AddShoppingViewModel: ObservableObject {
    
    private(set) var shoppingId: String?
    
    private(set) var mode: Mode = .add
    
    @Published var name: String = ""
    
    @Published var price: String = ""
    
    @Published var count: String = ""
        
    @Published var model: [Item] = []
    
    @Published var select: Item?
    
    @Published var itemId: String = ""
    
    @Published var inputItem = false
    
    @Published var alertFlag = false
    
    private(set) var alertType: AlertType = .success
    
    private(set) var alertMessage = ""
    
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
                setAlert(type: .error, message: "見つかりません")
            }
        }
    }
    
    func add() {
        do {
            if !inputItem {
                itemId = try Item.addItem(Item(name: name, price: price))
            }
            
            try Shopping.add(Shopping(itemId: itemId, count: count, purchased: PurchaseStatus.unPurchased.rawValue))
            setAlert(type: .success, message: "追加しました")
        } catch {
            setAlert(type: .error, message: "追加に失敗しました")
        }
        
        
    }
    
    func validation() -> Bool {
        print(itemId)
        print(inputItem)
        
        if inputItem {
            if itemId.isEmpty {
                setAlert(type: .error, message: "商品が選択されていません")
                return false
            } else if count.isEmpty {
                setAlert(type: .error, message: "個数が入力されていません")
                return false
            }

        } else {
            if name.isEmpty {
                setAlert(type: .error, message: "商品名が入力されていません")
                return false
            } else if price.isEmpty {
                setAlert(type: .error, message: "金額が入力されていません")
                return false
                
            } else if count.isEmpty {
                setAlert(type: .error, message: "個数が入力されていません")
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
            setAlert(type: .success, message: "更新しました")
        } catch {
            setAlert(type: .error, message: "更新に失敗しました")
        }
    }
    
    private func fetchItems() {
        do {
            model.append(Item())
             try Item.allFetch().forEach {
                model.append($0)
            }
        } catch {
            setAlert(type: .error, message: "見つかりません")
        }
    }
    
    private func setAlert(type: AlertType, message: String) {
        alertType = type
        alertMessage = message
        alertFlag = true
    }
    
}

